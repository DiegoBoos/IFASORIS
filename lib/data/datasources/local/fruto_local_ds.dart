import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/fruto.dart';

abstract class FrutoLocalDataSource {
  Future<List<FrutoModel>> getFrutos();
  Future<int> saveFruto(FrutoModel fruto);
  Future<int> saveUbicacionFrutos(int ubicacionId, List<LstFruto> lstFrutos);
  Future<List<LstFruto>> getUbicacionFrutos(int? ubicacionId);
}

class FrutoLocalDataSourceImpl implements FrutoLocalDataSource {
  @override
  Future<List<FrutoModel>> getFrutos() async {
    try {
      final res =
          await supabase.from('frutos_aspectossocioeconomicos').select();
      final result =
          List<FrutoModel>.from(res.map((m) => FrutoModel.fromJson(m)))
              .toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveFruto(FrutoModel fruto) async {
    try {
      await supabase
          .from('frutos_aspectossocioeconomicos')
          .upsert(fruto.toJson());

      return fruto.frutoId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstFruto>> getUbicacionFrutos(int? ubicacionId) async {
    try {
      final res = await supabase
          .from('asp1_ubicacionfrutos')
          .select()
          .eq('Ubicacion_id', ubicacionId);
      final result =
          List<LstFruto>.from(res.map((m) => LstFruto.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveUbicacionFrutos(
      int ubicacionId, List<LstFruto> lstFrutos) async {
    try {
      // First, delete existing records for the given ubicacionId
      await supabase
          .from('asp1_ubicacionfrutos')
          .delete()
          .eq('Ubicacion_id', ubicacionId);

      // Prepare the list of records to be inserted
      final ubicacionFrutos = lstFrutos
          .map((item) => {
                'frutoId': item.frutoId,
                'ubicacionId': ubicacionId,
              })
          .toList();

      // Insert the new records
      final res =
          await supabase.from('asp1_ubicacionfrutos').upsert(ubicacionFrutos);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
