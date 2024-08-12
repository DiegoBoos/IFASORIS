import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/dificultad_acceso_ca.dart';

abstract class DificultadAccesoCALocalDataSource {
  Future<List<DificultadAccesoCAModel>> getDificultadesAccesoCA();
  Future<int> saveDificultadAccesoCA(
      DificultadAccesoCAModel dificultadAccesoCA);

  Future<int> saveUbicacionDificultadesAcceso(int ubicacionId,
      List<LstDificultadAccesoAtencion> lstDificultadAccesoAtencion);

  Future<List<LstDificultadAccesoAtencion>> getUbicacionDificultadesAcceso(
      int? ubicacionId);
}

class DificultadAccesoCALocalDataSourceImpl
    implements DificultadAccesoCALocalDataSource {
  @override
  Future<List<DificultadAccesoCAModel>> getDificultadesAccesoCA() async {
    try {
      final res =
          await supabase.from('DificultadesAcceso_CentroAtencion').select();
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
      final res = await supabase
          .from('DificultadesAcceso_CentroAtencion')
          .insert(dificultadAccesoCA.toJson());

      return res;
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
          .from('Asp1_UbicacionDificultadAcceso')
          .delete()
          .eq('Ubicacion_id', ubicacionId);

      // Prepare the list of records to be inserted
      final ubicacionDificultadesAcceso = lstDificultadAccesoAtencion
          .map((item) => {
                'dificultadAccesoId': item.dificultaAccesoId,
                'ubicacionId': ubicacionId,
              })
          .toList();

      // Insert the new records
      final res = await supabase
          .from('Asp1_UbicacionDificultadAcceso')
          .insert(ubicacionDificultadesAcceso);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
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
          .from('Asp1_UbicacionDificultadAcceso')
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
}
