import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/medio_utiliza_ca.dart';

abstract class MedioUtilizaCALocalDataSource {
  Future<List<MedioUtilizaCAModel>> getMediosUtilizaCA();
  Future<int> saveMedioUtilizaCA(MedioUtilizaCAModel medioUtilizaCA);
  Future<List<LstMediosUtilizaCA>> getUbicacionMediosUtilizaCA(
      int? ubicacionId);
  Future<int> saveUbicacionMediosUtilizaCA(
      int ubicacionId, List<LstMediosUtilizaCA> lstMediosUtilizaCA);
}

class MedioUtilizaCALocalDataSourceImpl
    implements MedioUtilizaCALocalDataSource {
  @override
  Future<List<MedioUtilizaCAModel>> getMediosUtilizaCA() async {
    try {
      final res = await supabase.from('mediosutiliza_centroatencion').select();
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
      await supabase
          .from('mediosutiliza_centroatencion')
          .upsert(medioUtilizaCA.toJson());

      return medioUtilizaCA.medioUtilizaId!;
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
          .from('asp1_ubicacionmedioscentroatencion')
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
          .from('asp1_ubicacionmedioscentroatencion')
          .delete()
          .eq('Ubicacion_id', ubicacionId);

      // Prepare the list of records to be inserted
      final ubicacionMediosUtilizaCA = lstMediosUtilizaCA
          .map((item) => {
                'Ubicacion_id': ubicacionId,
                'MedioUtiliza_id': item.medioUtilizaId,
              })
          .toList();

      // Insert the new records
      await supabase
          .from('asp1_ubicacionmedioscentroatencion')
          .upsert(ubicacionMediosUtilizaCA);

      // Return the number of rows inserted
      return ubicacionMediosUtilizaCA.length;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
