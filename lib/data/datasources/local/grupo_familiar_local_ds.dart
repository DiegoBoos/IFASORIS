import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';

import '../../models/grupo_familiar.dart';

abstract class GrupoFamiliarLocalDataSource {
  Future<List<GrupoFamiliarModel>> getGrupoFamiliar(int familiaId);
  Future<GrupoFamiliarModel> saveGrupoFamiliar(
      GrupoFamiliarModel afiliadoGrupoFamiliar);
  Future<int> deleteAfiliadoGrupoFamiliar(int afiliadoId, int familiaId);
  Future<int> completeGrupoFamiliar(int afiliadoId);
  Future<bool> existeAfiliadoCabezaFamilia(int afiliadoId);
}

class GrupoFamiliarLocalDataSourceImpl implements GrupoFamiliarLocalDataSource {
  @override
  Future<List<GrupoFamiliarModel>> getGrupoFamiliar(int familiaId) async {
    try {
      final res = await supabase.from('asp3_grupofamiliar').select(''' 
            Afiliado:Afiliado_id ( 
             Afiliado_id,
             documento,
             Edad,
             fecnac,
             nombre1,
             nombre2,
             apellido1,
             apellido2,
             TipoDoc_Afiliado,
             CodGenero_Afiliado,
             CodRegimen_Afiliado)
            ''').eq('Familia_id', familiaId);

      final result = res
          .map<GrupoFamiliarModel>((m) => GrupoFamiliarModel.fromJson(m))
          .toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<GrupoFamiliarModel> saveGrupoFamiliar(
      GrupoFamiliarModel afiliadoGrupoFamiliar) async {
    try {
      Map<String, dynamic> grupoFamiliarJson;

      if (afiliadoGrupoFamiliar.grupoFamiliarId == null) {
        grupoFamiliarJson = afiliadoGrupoFamiliar.toJson();
        grupoFamiliarJson.remove('GrupoFamiliar_id');
      } else {
        grupoFamiliarJson = afiliadoGrupoFamiliar.toJson();
      }

      await supabase
          .from('asp3_grupofamiliar')
          .upsert(grupoFamiliarJson)
          .eq('Afiliado_id', afiliadoGrupoFamiliar.afiliadoId)
          .eq('Familia_id', afiliadoGrupoFamiliar.familiaId);

      final consultarAfiliado = await supabase
          .from('asp3_grupofamiliar')
          .select(
              'Afiliado.nombre1, Afiliado.nombre2, Afiliado.apellido1, Afiliado.apellido2, asp3_grupofamiliar.*')
          .eq('asp3_grupofamiliar.Afiliado_id',
              afiliadoGrupoFamiliar.afiliadoId)
          .eq('asp3_grupofamiliar.Familia_id', afiliadoGrupoFamiliar.familiaId)
          .maybeSingle(); // Use maybeSingle to return one result or null

      if (consultarAfiliado == null) {
        throw const DatabaseFailure(['Registro no encontrado']);
      }

      return GrupoFamiliarModel.fromJson(consultarAfiliado);
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> deleteAfiliadoGrupoFamiliar(int afiliadoId, int familiaId) async {
    try {
      final res = await supabase
          .from('asp3_grupofamiliar')
          .delete()
          .eq('Afiliado_id', afiliadoId)
          .eq('Familia_id', familiaId);

      return res.count ?? 0; // Supabase returns the number of affected rows
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> completeGrupoFamiliar(int afiliadoId) async {
    try {
      await supabase
          .from('asp3_grupofamiliar')
          .update({'isComplete': 1}).eq('Afiliado_id', afiliadoId);

      return 1;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<bool> existeAfiliadoCabezaFamilia(int afiliadoId) async {
    try {
      final res = await supabase
          .from('asp3_grupofamiliar')
          .select(
              'exists (select 1 from asp3_grupofamiliar Familia!inner(FK_Afiliado_id)')
          .eq('asp3_grupofamiliar.Afiliado_id', afiliadoId)
          .single();

      return res['exists'] as bool;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
