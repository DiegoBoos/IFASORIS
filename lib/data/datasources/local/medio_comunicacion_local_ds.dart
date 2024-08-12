import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/medio_comunicacion.dart';

abstract class MedioComunicacionLocalDataSource {
  Future<List<MedioComunicacionModel>> getMediosComunicacion();
  Future<int> saveMedioComunicacion(MedioComunicacionModel medioComunicacion);

  Future<int> saveUbicacionMediosComunicacion(
      int ubicacionId, List<LstMediosComunica> lstMediosComunica);

  Future<List<LstMediosComunica>> getUbicacionMediosComunicacion(
      int? ubicacionId);
}

class MedioComunicacionLocalDataSourceImpl
    implements MedioComunicacionLocalDataSource {
  @override
  Future<List<MedioComunicacionModel>> getMediosComunicacion() async {
    try {
      final res = await supabase.from('MediosComunicacion').select();
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
      final res = await supabase
          .from('MediosComunicacion')
          .insert(medioComunicacion.toJson());

      return res;
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
          .from('Asp1_UbicacionMediosComunicacion')
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
          .from('Asp1_UbicacionMediosComunicacion')
          .insert(ubicacionMediosComunicacion);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
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
          .from('Asp1_UbicacionMediosComunicacion')
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
}
