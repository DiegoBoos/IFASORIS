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
      // Insert the new family into the 'Familia' table
      final res = await supabase
          .from('Familia')
          .insert(familia.toJson())
          .select()
          .single();

      if (res.data == null) {
        throw const DatabaseFailure(['Failed to insert familia']);
      }

      // Update the familia model with the new ID
      final insertedFamilia = FamiliaModel.fromJson(res.data);
      final newFamilia = familia.copyWith(familiaId: insertedFamilia.familiaId);

      // Delete rows in the 'Asp3_GrupoFamiliar' table
      await supabase
          .from('Asp3_GrupoFamiliar')
          .delete()
          .eq('Afiliado_id', newFamilia.fkAfiliadoId);

      // Update other related tables one by one
      await supabase
          .from('Asp4_EstilosVidaSaludable')
          .update({'Familia_id': newFamilia.familiaId}).eq(
              'Afiliado_id', newFamilia.fkAfiliadoId);

      await supabase
          .from('Asp5_CuidadoSaludCondRiesgo')
          .update({'Familia_id': newFamilia.familiaId}).eq(
              'Afiliado_id', newFamilia.fkAfiliadoId);

      await supabase
          .from('Asp6_DimSocioCulturalPueblosIndigenas')
          .update({'Familia_id': newFamilia.familiaId}).eq(
              'Afiliado_id', newFamilia.fkAfiliadoId);

      await supabase
          .from('Asp7_AtencionSalud')
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
      final res = await supabase.from('Familia').select();
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
          .from('Familia')
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
