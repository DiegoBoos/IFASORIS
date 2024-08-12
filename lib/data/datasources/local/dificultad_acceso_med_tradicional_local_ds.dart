import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/dificultad_acceso_med_tradicional.dart';

abstract class DificultadAccesoMedTradicionalLocalDataSource {
  Future<List<DificultadAccesoMedTradicionalModel>>
      getDificultadesAccesoMedTradicional();
  Future<int> saveDificultadAccesoMedTradicional(
      DificultadAccesoMedTradicionalModel dificultadAccesoMedTradicional);

  Future<int> saveUbicacionAccesoMedTradicional(
      int ubicacionId,
      List<LstDificultadAccesoMedTradicional>
          lstDificultadAccesoMedTradicional);

  Future<List<LstDificultadAccesoMedTradicional>>
      getUbicacionDificultadesAccesoMedTradicional(int? ubicacionId);
}

class DificultadAccesoMedTradicionalLocalDataSourceImpl
    implements DificultadAccesoMedTradicionalLocalDataSource {
  @override
  Future<List<DificultadAccesoMedTradicionalModel>>
      getDificultadesAccesoMedTradicional() async {
    try {
      final res = await supabase
          .from('DificultadesAcceso_AccesoMedTradicional')
          .select();
      final result = List<DificultadAccesoMedTradicionalModel>.from(
              res.map((m) => DificultadAccesoMedTradicionalModel.fromJson(m)))
          .toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveDificultadAccesoMedTradicional(
      DificultadAccesoMedTradicionalModel
          dificultadAccesoMedTradicional) async {
    try {
      final res = await supabase
          .from('DificultadesAcceso_AccesoMedTradicional')
          .insert(dificultadAccesoMedTradicional.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveUbicacionAccesoMedTradicional(
      int ubicacionId,
      List<LstDificultadAccesoMedTradicional>
          lstDificultadAccesoMedTradicional) async {
    try {
      // First, delete existing records for the given ubicacionId
      await supabase
          .from('Asp1_UbicacionAccesoMedTradicional')
          .delete()
          .eq('Ubicacion_id', ubicacionId);

      // Prepare the list of records to be inserted
      final ubicacionDificultadesAccesoMedTradicional =
          lstDificultadAccesoMedTradicional
              .map((item) => {
                    'dificultadAccesoMedTradId': item.dificultadAccesoMedTradId,
                    'ubicacionId': ubicacionId,
                  })
              .toList();

      // Insert the new records
      final res = await supabase
          .from('Asp1_UbicacionAccesoMedTradicional')
          .insert(ubicacionDificultadesAccesoMedTradicional);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstDificultadAccesoMedTradicional>>
      getUbicacionDificultadesAccesoMedTradicional(int? ubicacionId) async {
    try {
      final res = await supabase
          .from('Asp1_UbicacionAccesoMedTradicional')
          .select()
          .eq('Ubicacion_id', ubicacionId);

      final result = List<LstDificultadAccesoMedTradicional>.from(
              res.map((m) => LstDificultadAccesoMedTradicional.fromJson(m)))
          .toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
