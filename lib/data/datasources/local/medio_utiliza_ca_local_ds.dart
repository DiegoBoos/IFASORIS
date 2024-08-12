import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/medio_utiliza_ca.dart';

abstract class MedioUtilizaCALocalDataSource {
  Future<List<MedioUtilizaCAModel>> getMediosUtilizaCA();
  Future<int> saveMedioUtilizaCA(MedioUtilizaCAModel medioUtilizaCA);
  Future<int> saveUbicacionMediosUtilizaCA(
      int ubicacionId, List<LstMediosUtilizaCA> lstMediosUtilizaCA);
  Future<List<LstMediosUtilizaCA>> getUbicacionMediosUtilizaCA(
      int? ubicacionId);
}

class MedioUtilizaCALocalDataSourceImpl
    implements MedioUtilizaCALocalDataSource {
  @override
  Future<List<MedioUtilizaCAModel>> getMediosUtilizaCA() async {
    try {
      final res = await supabase.from('MediosUtiliza_CentroAtencion').select();
      final mediosUtilizaCADB = List<MedioUtilizaCAModel>.from(
          res.map((m) => MedioUtilizaCAModel.fromJson(m))).toList();

      return mediosUtilizaCADB;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveMedioUtilizaCA(MedioUtilizaCAModel medioUtilizaCA) async {
    try {
      final res = await supabase
          .from('MediosUtiliza_CentroAtencion')
          .insert(medioUtilizaCA.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstMediosUtilizaCA>> getUbicacionMediosUtilizaCA(
      int? ubicacionId) async {
    try {
      final res = await supabase
          .from('Asp1_UbicacionMediosCentroAtencion')
          .select()
          .eq('Ubicacion_id', ubicacionId);

      final result = List<LstMediosUtilizaCA>.from(
          res.map((m) => LstMediosUtilizaCA.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveUbicacionMediosUtilizaCA(
      int ubicacionId, List<LstMediosUtilizaCA> lstMediosUtilizaCA) async {
    try {
      // First, delete existing records for the given ubicacionId
      await supabase
          .from('Asp1_UbicacionMediosCentroAtencion')
          .delete()
          .eq('Ubicacion_id', ubicacionId);

      // Prepare the list of records to be inserted
      final ubicacionMediosUtilizaCA = lstMediosUtilizaCA
          .map((item) => {
                'ubicacionId': ubicacionId,
                'medioUtilizaId': item.medioUtilizaId,
              })
          .toList();

      // Insert the new records
      final res = await supabase
          .from('Asp1_UbicacionMediosCentroAtencion')
          .insert(ubicacionMediosUtilizaCA);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
