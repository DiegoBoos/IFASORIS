import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/medio_utiliza_med_tradicional.dart';

abstract class MedioUtilizaMedTradicionalLocalDataSource {
  Future<List<MedioUtilizaMedTradicionalModel>>
      getMediosUtilizaMedTradicional();
  Future<int> saveMedioUtilizaMedTradicional(
      MedioUtilizaMedTradicionalModel medioUtilizaMedTradicional);

  Future<int> saveUbicacionMediosMedTradicional(
      int ubicacionId, List<LstMediosMedTradicional> lstMediosMedTradicional);

  Future<List<LstMediosMedTradicional>> getUbicacionMediosUtilizaMedTradicional(
      int? ubicacionId);
}

class MedioUtilizaMedTradicionalLocalDataSourceImpl
    implements MedioUtilizaMedTradicionalLocalDataSource {
  @override
  Future<List<MedioUtilizaMedTradicionalModel>>
      getMediosUtilizaMedTradicional() async {
    try {
      final res =
          await supabase.from('MediosUtiliza_AccesoMedTradicional').select();
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
      final res = await supabase
          .from('MediosUtiliza_AccesoMedTradicional')
          .insert(medioUtilizaMedTradicional.toJson());

      return res;
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
          .from('Asp1_UbicacionMediosMedTradicional')
          .delete()
          .eq('Ubicacion_id', ubicacionId);

      // Prepare the list of records to be inserted
      final ubicacionMediosMedTradicional = lstMediosMedTradicional
          .map((item) => {
                'medioUtilizaMedTradicionalId': item.medioUtilizaMedTradId,
                'ubicacionId': ubicacionId,
              })
          .toList();

      // Insert the new records
      final res = await supabase
          .from('Asp1_UbicacionMediosMedTradicional')
          .insert(ubicacionMediosMedTradicional);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure(
          ['Error saving medios med tradicional for ubicacion']);
    }
  }

  @override
  Future<List<LstMediosMedTradicional>> getUbicacionMediosUtilizaMedTradicional(
      int? ubicacionId) async {
    try {
      final res = await supabase
          .from('Asp1_UbicacionMediosMedTradicional')
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
}
