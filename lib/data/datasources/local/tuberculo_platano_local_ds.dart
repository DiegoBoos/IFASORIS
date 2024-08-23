import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/tuberculo_platano.dart';

abstract class TuberculoPlatanoLocalDataSource {
  Future<List<TuberculoPlatanoModel>> getTuberculosPlatanos();
  Future<int> saveTuberculoPlatano(TuberculoPlatanoModel tuberculoPlatano);
  Future<List<LstTuberculo>> getUbicacionTuberculosPlatanos(int? ubicacionId);
  Future<int> saveUbicacionTuberculosPlatanos(
      int ubicacionId, List<LstTuberculo> lstTuberculos);
}

class TuberculoPlatanoLocalDataSourceImpl
    implements TuberculoPlatanoLocalDataSource {
  @override
  Future<List<TuberculoPlatanoModel>> getTuberculosPlatanos() async {
    try {
      final res = await supabase
          .from('tuberculosplatanos_aspectossocioeconomicos')
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
      await supabase
          .from('tuberculosplatanos_aspectossocioeconomicos')
          .upsert(tuberculoPlatano.toJson());

      return tuberculoPlatano.tuberculoPlatanoId!;
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
          .from('asp1_ubicaciontuberculosplatanos')
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

  @override
  Future<int> saveUbicacionTuberculosPlatanos(
      int ubicacionId, List<LstTuberculo> lstTuberculos) async {
    try {
      // First, delete existing records for the given ubicacionId
      await supabase
          .from('asp1_ubicaciontuberculosplatanos')
          .delete()
          .eq('Ubicacion_id', ubicacionId);

      // Prepare the list of records to be inserted
      final ubicacionTuberculosPlatanos = lstTuberculos
          .map((item) => {
                'TuberculoPlatano_id': item.tuberculoPlatanoId,
                'Ubicacion_id': ubicacionId,
                'OtroTuberculoPlatano': item.otroTuberculoPlatano,
              })
          .toList();

      // Insert the new records
      await supabase
          .from('asp1_ubicaciontuberculosplatanos')
          .upsert(ubicacionTuberculosPlatanos);

      // Return the number of rows inserted
      return ubicacionTuberculosPlatanos.length;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
