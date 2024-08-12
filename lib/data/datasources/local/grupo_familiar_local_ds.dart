import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';

import '../../models/grupo_familiar.dart';

abstract class GrupoFamiliarLocalDataSource {
  Future<GrupoFamiliarModel> saveGrupoFamiliar(
      GrupoFamiliarModel afiliadoGrupoFamiliar);

  Future<List<GrupoFamiliarModel>> getGrupoFamiliar(int familiaId);

  Future<int> deleteAfiliadoGrupoFamiliar(int afiliadoId, int familiaId);

  Future<int> completeGrupoFamiliar(int afiliadoId);

  Future<bool> existeAfiliadoCabezaFamilia(int afiliadoId);
}

class GrupoFamiliarLocalDataSourceImpl implements GrupoFamiliarLocalDataSource {
  @override
  Future<GrupoFamiliarModel> saveGrupoFamiliar(
      GrupoFamiliarModel afiliadoGrupoFamiliar) async {
    try {
      if (afiliadoGrupoFamiliar.grupoFamiliarId == null) {
        await supabase.from('Asp3_GrupoFamiliar').insert(
              afiliadoGrupoFamiliar.toJson(),
            );
      } else {
        await supabase
            .from('Asp3_GrupoFamiliar')
            .update(
              afiliadoGrupoFamiliar.toJson(),
            )
            .eq('Afiliado_id', afiliadoGrupoFamiliar.afiliadoId)
            .eq('Familia_id', afiliadoGrupoFamiliar.familiaId);
      }

      final consultarAfiliado = await supabase
          .from('Asp3_GrupoFamiliar')
          .select(
              'Afiliado.nombre1, Afiliado.nombre2, Afiliado.apellido1, Afiliado.apellido2, Asp3_GrupoFamiliar.*')
          .eq('Asp3_GrupoFamiliar.Afiliado_id',
              afiliadoGrupoFamiliar.afiliadoId)
          .eq('Asp3_GrupoFamiliar.Familia_id', afiliadoGrupoFamiliar.familiaId)
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
  Future<List<GrupoFamiliarModel>> getGrupoFamiliar(int familiaId) async {
    try {
      final res = await supabase
          .from('Asp3_GrupoFamiliar')
          .select('Afiliado.*, Asp3_GrupoFamiliar.*')
          .eq('Familia_id', familiaId);

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
  Future<int> deleteAfiliadoGrupoFamiliar(int afiliadoId, int familiaId) async {
    try {
      final res = await supabase
          .from('Asp3_GrupoFamiliar')
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
      final res = await supabase
          .from('Asp3_GrupoFamiliar')
          .update({'isComplete': 1}).eq('Afiliado_id', afiliadoId);

      return res.count ?? 0; // Supabase returns the number of affected rows
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
          .from('Asp3_GrupoFamiliar')
          .select(
              'exists (select 1 from Asp3_GrupoFamiliar inner join Familia on Asp3_GrupoFamiliar.Afiliado_id = Familia.FK_Afiliado_id where Asp3_GrupoFamiliar.Afiliado_id = $afiliadoId)')
          .single(); // Use single to get the result of the exists query

      return res['exists'] as bool;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
