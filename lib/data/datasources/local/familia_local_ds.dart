import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/familia.dart';

abstract class FamiliaLocalDataSource {
  Future<FamiliaModel> createFamilia(FamiliaModel familia);
  Future<List<FamiliaModel>> loadFamilias();
  Future<int> deleteAfiliadoFamilia(int fkAfiliadoId);
}

class FamiliaLocalDataSourceImpl implements FamiliaLocalDataSource {
  @override
  Future<FamiliaModel> createFamilia(FamiliaModel familia) async {
    try {
      final res = await supabase
          .from('familia')
          .upsert(familia.toJsonSupabase())
          .select()
          .single();

      // Update the familia model with the new ID
      final newFamilia = FamiliaModel.fromJson(res);

      // Delete rows in the 'asp3_grupofamiliar' table
      await supabase
          .from('asp3_grupofamiliar')
          .delete()
          .eq('Afiliado_id', newFamilia.fkAfiliadoId);

      // Update other related tables one by one
      await supabase
          .from('asp4_estilosvidasaludable')
          .update({'Familia_id': newFamilia.familiaId}).eq(
              'Afiliado_id', newFamilia.fkAfiliadoId);

      await supabase
          .from('asp5_cuidadosaludcondriesgo')
          .update({'Familia_id': newFamilia.familiaId}).eq(
              'Afiliado_id', newFamilia.fkAfiliadoId);

      await supabase
          .from('asp6_dimsocioculturalpueblosindigenas')
          .update({'Familia_id': newFamilia.familiaId}).eq(
              'Afiliado_id', newFamilia.fkAfiliadoId);

      await supabase
          .from('asp7_atencionsalud')
          .update({'Familia_id': newFamilia.familiaId}).eq(
              'Afiliado_id', newFamilia.fkAfiliadoId);

      return FamiliaModel.fromEntity(newFamilia);
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<FamiliaModel>> loadFamilias() async {
    try {
      final res = await supabase.from('familia').select();
      final result =
          List<FamiliaModel>.from(res.map((m) => FamiliaModel.fromJson(m)))
              .toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> deleteAfiliadoFamilia(int fkAfiliadoId) async {
    try {
      final res = await supabase
          .from('familia')
          .delete()
          .eq('FK_Afiliado_id', fkAfiliadoId);

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
