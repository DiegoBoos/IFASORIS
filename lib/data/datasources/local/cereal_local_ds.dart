import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/cereal.dart';

abstract class CerealLocalDataSource {
  Future<List<CerealModel>> getCereales();
  Future<int> saveCereal(CerealModel cereal);
  Future<List<LstCereal>> getUbicacionCereales(int? ubicacionId);
  Future<int> saveUbicacionCereales(
      int ubicacionId, List<LstCereal> lstCereales);
}

class CerealLocalDataSourceImpl implements CerealLocalDataSource {
  @override
  Future<List<CerealModel>> getCereales() async {
    try {
      final res =
          await supabase.from('cereales_aspectossocioeconomicos').select();
      final result =
          List<CerealModel>.from(res.map((m) => CerealModel.fromJson(m)))
              .toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveCereal(CerealModel cereal) async {
    try {
      await supabase
          .from('cereales_aspectossocioeconomicos')
          .upsert(cereal.toJson());

      return cereal.cerealId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstCereal>> getUbicacionCereales(int? ubicacionId) async {
    try {
      final res = await supabase
          .from('asp1_ubicacioncereales')
          .select()
          .eq('Ubicacion_id', ubicacionId);
      final result =
          List<LstCereal>.from(res.map((m) => LstCereal.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveUbicacionCereales(
      int ubicacionId, List<LstCereal> lstCereales) async {
    try {
      // First, delete existing records for the given ubicacionId
      await supabase
          .from('asp1_ubicacioncereales')
          .delete()
          .eq('Ubicacion_id', ubicacionId);

      // Prepare the list of records to be inserted
      final ubicacionCereales = lstCereales
          .map((item) => {
                'cerealId': item.cerealId,
                'ubicacionId': ubicacionId,
                'otroCereal': item.otroCereal,
              })
          .toList();

      // Insert the new records
      final res = await supabase
          .from('asp1_ubicacioncereales')
          .upsert(ubicacionCereales);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
