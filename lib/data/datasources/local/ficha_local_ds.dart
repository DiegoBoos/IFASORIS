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
  Future<void> updateFicha(int fichaIdLocal, int numFicha);
}

class FichaLocalDataSourceImpl implements FichaLocalDataSource {
  @override
  Future<FichaModel> createFicha(FichaModel ficha) async {
    try {
      final res = await supabase
          .from('ficha')
          .upsert(ficha.toJsonLocal())
          .select()
          .single();
      final newFicha = FichaModel.fromJson(res);
      return newFicha;
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
          ficha(
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

      final resFichasReportadas = await supabase
          .from('ficha')
          .select('*', const FetchOptions(count: CountOption.exact))
          .neq('NumFicha', '')
          .or('Ficha_id_remote.not.is.null');

      results.add({
        'Estadistica': 'FichasReportadas',
        'Cantidad': resFichasReportadas.count
      });

      final resFichasRegistradas = await supabase
          .from('ficha')
          .select('*', const FetchOptions(count: CountOption.exact))
          .eq('NumFicha', '')
          .is_('Ficha_id_remote', null);

      results.add({
        'Estadistica': 'FichasRegistradas',
        'Cantidad': resFichasRegistradas.count
      });

      final resFichasIncompletas = await supabase
          .from('ficha')
          .select(
              '*, familia(Ficha_id)',
              /* asp3_grupofamiliar(Familia_id) */
              const FetchOptions(count: CountOption.exact))
          .eq('NumFicha', '')
          .is_('Ficha_id_remote', null);
      /* .is_('asp3_grupofamiliar.isComplete', null); */

      results.add({
        'Estadistica': 'FichasRegistradasIncompletas',
        'Cantidad': resFichasIncompletas.count
      });

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
          .select('*, familia(Ficha_id)')
          .neq('NumFicha', '')
          .neq('Ficha_id_remote', 0);

      final result = res.map<FichaModel>((ficha) {
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
      final newFicha =
          ficha.copyWith(fichaIdRemote: ficha.fichaId, fichaId: null);

      // Familia
      var familia = newFicha.familia?.copyWith(familiaId: null);

      // GrupoFamiliar
      final grupoFamiliar = newFicha.familia?.grupoFamiliar;

      // Insert Ficha
      final fichaRes = await supabase
          .from('ficha')
          .upsert(newFicha.toJsonLocal())
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
            'codRegimenAfiliado': integrante.codRegimenAfiliado,
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

      return newFicha;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<void> updateFicha(int fichaIdLocal, int numFicha) async {
    try {
      await supabase
          .from('Ficha')
          .update({'NumFicha': numFicha}).eq('Ficha_id', fichaIdLocal);
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
