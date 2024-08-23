import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/dificultad_acceso_ca.dart';

abstract class DificultadAccesoCALocalDataSource {
  Future<List<DificultadAccesoCAModel>> getDificultadesAccesoCA();
  Future<int> saveDificultadAccesoCA(
      DificultadAccesoCAModel dificultadAccesoCA);
  Future<List<LstDificultadAccesoAtencion>> getUbicacionDificultadesAcceso(
      int? ubicacionId);
  Future<int> saveUbicacionDificultadesAcceso(int ubicacionId,
      List<LstDificultadAccesoAtencion> lstDificultadAccesoAtencion);
}

class DificultadAccesoCALocalDataSourceImpl
    implements DificultadAccesoCALocalDataSource {
  @override
  Future<List<DificultadAccesoCAModel>> getDificultadesAccesoCA() async {
    try {
      final res =
          await supabase.from('dificultadesacceso_centroatencion').select();
      final result = List<DificultadAccesoCAModel>.from(
          res.map((m) => DificultadAccesoCAModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveDificultadAccesoCA(
      DificultadAccesoCAModel dificultadAccesoCA) async {
    try {
      await supabase
          .from('dificultadesacceso_centroatencion')
          .upsert(dificultadAccesoCA.toJson());

      return dificultadAccesoCA.dificultaAccesoId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstDificultadAccesoAtencion>> getUbicacionDificultadesAcceso(
      int? ubicacionId) async {
    try {
      final res = await supabase
          .from('asp1_ubicaciondificultadacceso')
          .select()
          .eq('Ubicacion_id', ubicacionId);

      final result = List<LstDificultadAccesoAtencion>.from(
          res.map((m) => LstDificultadAccesoAtencion.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveUbicacionDificultadesAcceso(int ubicacionId,
      List<LstDificultadAccesoAtencion> lstDificultadAccesoAtencion) async {
    try {
      // First, delete existing records for the given ubicacionId
      await supabase
          .from('asp1_ubicaciondificultadacceso')
          .delete()
          .eq('Ubicacion_id', ubicacionId);

      // Prepare the list of records to be inserted
      final ubicacionDificultadesAcceso = lstDificultadAccesoAtencion
          .map((item) => {
                'DificultaAcceso_id': item.dificultaAccesoId,
                'Ubicacion_id': ubicacionId,
              })
          .toList();

      // Insert the new records
      await supabase
          .from('asp1_ubicaciondificultadacceso')
          .upsert(ubicacionDificultadesAcceso);

      // Return the number of rows inserted
      return ubicacionDificultadesAcceso.length;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
