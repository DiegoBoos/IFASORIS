import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/medio_utiliza_med_tradicional.dart';

abstract class MedioUtilizaMedTradicionalLocalDataSource {
  Future<List<MedioUtilizaMedTradicionalModel>>
      getMediosUtilizaMedTradicional();
  Future<int> saveMedioUtilizaMedTradicional(
      MedioUtilizaMedTradicionalModel medioUtilizaMedTradicional);
  Future<List<LstMediosMedTradicional>> getUbicacionMediosUtilizaMedTradicional(
      int? ubicacionId);
  Future<int> saveUbicacionMediosMedTradicional(
      int ubicacionId, List<LstMediosMedTradicional> lstMediosMedTradicional);
}

class MedioUtilizaMedTradicionalLocalDataSourceImpl
    implements MedioUtilizaMedTradicionalLocalDataSource {
  @override
  Future<List<MedioUtilizaMedTradicionalModel>>
      getMediosUtilizaMedTradicional() async {
    try {
      final res =
          await supabase.from('mediosutiliza_accesomedtradicional').select();
      final result = List<MedioUtilizaMedTradicionalModel>.from(
          res.map((m) => MedioUtilizaMedTradicionalModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveMedioUtilizaMedTradicional(
      MedioUtilizaMedTradicionalModel medioUtilizaMedTradicional) async {
    try {
      await supabase
          .from('mediosutiliza_accesomedtradicional')
          .upsert(medioUtilizaMedTradicional.toJson());

      return medioUtilizaMedTradicional.medioUtilizaMedTradId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstMediosMedTradicional>> getUbicacionMediosUtilizaMedTradicional(
      int? ubicacionId) async {
    try {
      final res = await supabase
          .from('asp1_ubicacionmediosmedtradicional')
          .select()
          .eq('Ubicacion_id', ubicacionId);
      final result = List<LstMediosMedTradicional>.from(
          res.map((m) => LstMediosMedTradicional.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveUbicacionMediosMedTradicional(int ubicacionId,
      List<LstMediosMedTradicional> lstMediosMedTradicional) async {
    try {
      // First, delete existing records for the given ubicacionId
      await supabase
          .from('asp1_ubicacionmediosmedtradicional')
          .delete()
          .eq('Ubicacion_id', ubicacionId);

      // Prepare the list of records to be inserted
      final ubicacionMediosMedTradicional = lstMediosMedTradicional
          .map((item) => {
                'MedioUtilizaMedTrad_id': item.medioUtilizaMedTradId,
                'Ubicacion_id': ubicacionId,
              })
          .toList();

      // Insert the new records
      await supabase
          .from('asp1_ubicacionmediosmedtradicional')
          .upsert(ubicacionMediosMedTradicional);

      // Return the number of rows inserted
      return ubicacionMediosMedTradicional.length;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure(
          [unexpectedErrorMessage]); // This is the only difference
    }
  }
}
