import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/estadistica.dart';
import '../../models/familia.dart';
import '../../models/ficha.dart';

abstract class FichaLocalDataSource {
  Future<FichaModel> createFicha(FichaModel ficha);
  Future<FichaModel> createFichaCompleta(FichaModel ficha);
  Future<List<FichaModel>> loadFichas(int familiaId);
  Future<List<EstadisticaModel>> loadEstadisticas();
  Future<int> deleteFicha(int fichaId);
  Future<List<FichaModel>> loadFichasSincronizadas();
}

class FichaLocalDataSourceImpl implements FichaLocalDataSource {
  @override
  Future<FichaModel> createFicha(FichaModel ficha) async {
    try {
      final res = await supabase.from('ficha').upsert(ficha.toJsonLocal());

      ficha.copyWith(fichaId: res);

      return ficha;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<FichaModel>> loadFichas(int familiaId) async {
    try {
      final res = await supabase.from('familia').select('''
          Ficha.*,
          Ficha(
           Ficha_id,
          )
          ''').eq('Familia_id', familiaId);

      final result = List<FichaModel>.from(
          res.map((m) => FichaModel.fromJson(m)).toList());

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<EstadisticaModel>> loadEstadisticas() async {
    try {
      final List<Map<String, dynamic>> results = [];

      // Fichas Reportadas
      final resFichasReportadas = await supabase
          .from('ficha')
          .select('count(*) as Cantidad')
          .neq('NumFicha', '')
          .or('Ficha_id_remote.not.is.null');
      results.add({
        'Estadistica': 'FichasReportadas',
        'Cantidad': resFichasReportadas.data[0]['Cantidad']
      });

      // Fichas Registradas
      final resFichasRegistradas = await supabase
          .from('ficha')
          .select('count(*) as Cantidad')
          .eq('NumFicha', '')
          .is_('Ficha_id_remote', null);

      if (resFichasRegistradas.isNotEmpty) {
        results.add({
          'Estadistica': 'FichasRegistradas',
          'Cantidad': resFichasRegistradas[0]['Cantidad']
        });
      }

      // Fichas Registradas Incompletas (Simplified)
      final resFichasIncompletas = await supabase
          .from('ficha')
          .select(
              'count(*) as Cantidad, Familia!inner(Ficha_id), asp3_grupofamiliar!left(isComplete)')
          .eq('NumFicha', '')
          .is_('Ficha_id_remote', null)
          .is_('asp3_grupofamiliar.isComplete', null);

      if (resFichasIncompletas.isNotEmpty) {
        results.add({
          'Estadistica': 'FichasRegistradasIncompletas',
          'Cantidad': resFichasIncompletas[0]['Cantidad']
        });
      }

      // Additional queries like this need to be constructed similarly

      final result = results.map((m) => EstadisticaModel.fromJson(m)).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> deleteFicha(int fichaId) async {
    try {
      final res = await supabase.from('ficha').delete().eq('Ficha_id', fichaId);
      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<FichaModel>> loadFichasSincronizadas() async {
    try {
      final res = await supabase
          .from('ficha')
          .select('Ficha.*, Familia.*, Familia!inner(Ficha_id)')
          .or('NumFicha.not.eq.("")')
          .or('Ficha_id_remote.not.is.null');

      final result = res.data.map<FichaModel>((ficha) {
        final familia = FamiliaModel.fromJson(ficha['Familia']);
        Map<String, dynamic> fichaConFamilia = {
          ...ficha,
          'familia': familia.toJson()
        };
        return FichaModel.fromJson(fichaConFamilia);
      }).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<FichaModel> createFichaCompleta(FichaModel ficha) async {
    try {
      // Copy the ficha with a new fichaIdRemote and null fichaId
      ficha = ficha.copyWith(fichaIdRemote: ficha.fichaId, fichaId: null);

      // Familia
      var familia = ficha.familia?.copyWith(familiaId: null);

      // GrupoFamiliar
      final grupoFamiliar = ficha.familia?.grupoFamiliar;

      // Insert Ficha
      final fichaRes = await supabase
          .from('ficha')
          .upsert(ficha.toJsonLocal())
          .select()
          .single();
      final newFichaId = fichaRes.data['Ficha_id'];

      // Update the familia with the new fichaId
      familia = familia?.copyWith(fichaId: newFichaId);
      final newFamilia = FamiliaModel.fromEntity(familia!);

      final familiaRes = await supabase
          .from('familia')
          .upsert(newFamilia.toJson())
          .select()
          .single();
      final newFamiliaId = familiaRes.data['Familia_id'];

      // Insert GrupoFamiliar records
      if (grupoFamiliar != null) {
        final grupoFamiliarData = grupoFamiliar.map((integrante) {
          return {
            'familiaId': newFamiliaId,
            'afiliadoId': integrante.afiliadoId,
            'tipoDocumentoId': integrante.tipoDocumentoId,
            'documento': integrante.documento,
            'generoId': integrante.generoId,
            'fechaNacimiento': integrante.fechaNacimiento,
            'edad': integrante.edad,
            'nombre1': integrante.nombre1,
            'nombre2': integrante.nombre2,
            'apellido1': integrante.apellido1,
            'apellido2': integrante.apellido2,
            'tipoDocAfiliado': integrante.tipoDocAfiliado,
            'codGeneroAfiliado': integrante.codGeneroAfiliado,
            'codTipoRegimenAfiliado': integrante.codTipoRegimenAfiliado,
            'tipoRegimenId': integrante.tipoRegimenId,
            'parentescoId': integrante.parentescoId,
            'etniaId': integrante.etniaId,
            'cursoVidaId': integrante.cursoVidaId,
            'nivelEducativoId': integrante.nivelEducativoId,
            'ocupacionId': integrante.ocupacionId,
            'grupoRiesgoId': integrante.grupoRiesgoId,
            'origenEtnico5602Id': integrante.origenEtnico5602Id,
            'puebloIndigenaId': integrante.puebloIndigenaId,
            'lenguaManejaId': integrante.lenguaManejaId,
            'lenguaMaternaId': integrante.lenguaMaternaId,
          };
        }).toList();

        for (var e in grupoFamiliarData) {
          await supabase.from('asp3_grupofamiliar').upsert(e);
        }
      }

      return ficha;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure(['Error creating complete ficha']);
    }
  }
}
