import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/tuberculo_platano.dart';

abstract class TuberculoPlatanoLocalDataSource {
  Future<List<TuberculoPlatanoModel>> getTuberculosPlatanos();
  Future<int> saveTuberculoPlatano(TuberculoPlatanoModel tuberculoPlatano);

  Future<int> saveUbicacionTuberculosPlatanos(
      int ubicacionId, List<LstTuberculo> lstTuberculos);

  Future<List<LstTuberculo>> getUbicacionTuberculosPlatanos(int? ubicacionId);
}

class TuberculoPlatanoLocalDataSourceImpl
    implements TuberculoPlatanoLocalDataSource {
  @override
  Future<List<TuberculoPlatanoModel>> getTuberculosPlatanos() async {
    try {
      final res = await supabase
          .from('TuberculosPlatanos_AspectosSocioEconomicos')
          .select();
      final result = List<TuberculoPlatanoModel>.from(
          res.map((m) => TuberculoPlatanoModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveTuberculoPlatano(
      TuberculoPlatanoModel tuberculoPlatano) async {
    try {
      final res = await supabase
          .from('TuberculosPlatanos_AspectosSocioEconomicos')
          .insert(tuberculoPlatano.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveUbicacionTuberculosPlatanos(
      int ubicacionId, List<LstTuberculo> lstTuberculos) async {
    try {
      // First, delete existing records for the given ubicacionId
      await supabase
          .from('Asp1_UbicacionTuberculosPlatanos')
          .delete()
          .eq('Ubicacion_id', ubicacionId);

      // Prepare the list of records to be inserted
      final ubicacionTuberculosPlatanos = lstTuberculos
          .map((item) => {
                'tuberculoPlatanoId': item.tuberculoPlatanoId,
                'ubicacionId': ubicacionId,
                'otroTuberculoPlatano': item.otroTuberculoPlatano,
              })
          .toList();

      // Insert the new records
      final res = await supabase
          .from('Asp1_UbicacionTuberculosPlatanos')
          .insert(ubicacionTuberculosPlatanos);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstTuberculo>> getUbicacionTuberculosPlatanos(
      int? ubicacionId) async {
    try {
      final res = await supabase
          .from('Asp1_UbicacionTuberculosPlatanos')
          .select()
          .eq('Ubicacion_id', ubicacionId);
      final result =
          List<LstTuberculo>.from(res.map((m) => LstTuberculo.fromJson(m)))
              .toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
