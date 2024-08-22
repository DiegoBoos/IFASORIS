import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/medio_comunicacion.dart';

abstract class MedioComunicacionLocalDataSource {
  Future<List<MedioComunicacionModel>> getMediosComunicacion();
  Future<int> saveMedioComunicacion(MedioComunicacionModel medioComunicacion);
  Future<List<LstMediosComunica>> getUbicacionMediosComunicacion(
      int? ubicacionId);
  Future<int> saveUbicacionMediosComunicacion(
      int ubicacionId, List<LstMediosComunica> lstMediosComunica);
}

class MedioComunicacionLocalDataSourceImpl
    implements MedioComunicacionLocalDataSource {
  @override
  Future<List<MedioComunicacionModel>> getMediosComunicacion() async {
    try {
      final res = await supabase.from('medioscomunicacion').select();
      final mediosComunicacionDB = List<MedioComunicacionModel>.from(
          res.map((m) => MedioComunicacionModel.fromJson(m))).toList();

      return mediosComunicacionDB;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveMedioComunicacion(
      MedioComunicacionModel medioComunicacion) async {
    try {
      await supabase
          .from('medioscomunicacion')
          .upsert(medioComunicacion.toJson());

      return medioComunicacion.medioComunicacionId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstMediosComunica>> getUbicacionMediosComunicacion(
      int? ubicacionId) async {
    try {
      final res = await supabase
          .from('asp1_ubicacionmedioscomunicacion')
          .select()
          .eq('Ubicacion_id', ubicacionId);
      final ubicacionMediosComunicacionDB = List<LstMediosComunica>.from(
          res.map((m) => LstMediosComunica.fromJson(m))).toList();

      return ubicacionMediosComunicacionDB;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveUbicacionMediosComunicacion(
      int ubicacionId, List<LstMediosComunica> lstMediosComunica) async {
    try {
      // First, delete existing records for the given ubicacionId
      await supabase
          .from('asp1_ubicacionmedioscomunicacion')
          .delete()
          .eq('Ubicacion_id', ubicacionId);

      // Prepare the list of records to be inserted
      final ubicacionMediosComunicacion = lstMediosComunica
          .map((item) => {
                'medioComunicacionId': item.medioComunicacionId,
                'ubicacionId': ubicacionId,
              })
          .toList();

      // Insert the new records
      final res = await supabase
          .from('asp1_ubicacionmedioscomunicacion')
          .upsert(ubicacionMediosComunicacion);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
