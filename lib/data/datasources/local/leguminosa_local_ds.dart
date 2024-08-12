import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/leguminosa.dart';

abstract class LeguminosaLocalDataSource {
  Future<List<LeguminosaModel>> getLeguminosas();
  Future<int> saveLeguminosa(LeguminosaModel leguminosa);

  Future<int> saveUbicacionLeguminosas(
      int ubicacionId, List<LstLeguminosa> lstLeguminosas);

  Future<List<LstLeguminosa>> getUbicacionLeguminosas(int? ubicacionId);
}

class LeguminosaLocalDataSourceImpl implements LeguminosaLocalDataSource {
  @override
  Future<List<LeguminosaModel>> getLeguminosas() async {
    try {
      final res =
          await supabase.from('Leguminosas_AspectosSocioEconomicos').select();
      final result = List<LeguminosaModel>.from(
          res.map((m) => LeguminosaModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveLeguminosa(LeguminosaModel leguminosa) async {
    try {
      final res = await supabase
          .from('Leguminosas_AspectosSocioEconomicos')
          .insert(leguminosa.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveUbicacionLeguminosas(
      int ubicacionId, List<LstLeguminosa> lstLeguminosas) async {
    try {
      // First, delete existing records for the given ubicacionId
      await supabase
          .from('Asp1_UbicacionLeguminosas')
          .delete()
          .eq('Ubicacion_id', ubicacionId);

      // Prepare the list of records to be inserted
      final ubicacionLeguminosas = lstLeguminosas
          .map((item) => {
                'leguminosaId': item.leguminosaId,
                'ubicacionId': ubicacionId,
              })
          .toList();

      // Insert the new records
      final res = await supabase
          .from('Asp1_UbicacionLeguminosas')
          .insert(ubicacionLeguminosas);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstLeguminosa>> getUbicacionLeguminosas(int? ubicacionId) async {
    try {
      final res = await supabase
          .from('Asp1_UbicacionLeguminosas')
          .select()
          .eq('Ubicacion_id', ubicacionId);
      final result =
          List<LstLeguminosa>.from(res.map((m) => LstLeguminosa.fromJson(m)))
              .toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
