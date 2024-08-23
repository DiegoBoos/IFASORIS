import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/dificultad_acceso_med_tradicional.dart';

abstract class DificultadAccesoMedTradicionalLocalDataSource {
  Future<List<DificultadAccesoMedTradicionalModel>>
      getDificultadesAccesoMedTradicional();
  Future<int> saveDificultadAccesoMedTradicional(
      DificultadAccesoMedTradicionalModel dificultadAccesoMedTradicional);
  Future<List<LstDificultadAccesoMedTradicional>>
      getUbicacionDificultadesAccesoMedTradicional(int? ubicacionId);
  Future<int> saveUbicacionAccesoMedTradicional(
      int ubicacionId,
      List<LstDificultadAccesoMedTradicional>
          lstDificultadAccesoMedTradicional);
}

class DificultadAccesoMedTradicionalLocalDataSourceImpl
    implements DificultadAccesoMedTradicionalLocalDataSource {
  @override
  Future<List<DificultadAccesoMedTradicionalModel>>
      getDificultadesAccesoMedTradicional() async {
    try {
      final res = await supabase
          .from('dificultadesacceso_accesomedtradicional')
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
      await supabase
          .from('dificultadesacceso_accesomedtradicional')
          .upsert(dificultadAccesoMedTradicional.toJson());

      return dificultadAccesoMedTradicional.dificultadAccesoMedTradId!;
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
          .from('asp1_ubicacionaccesomedtradicional')
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

  @override
  Future<int> saveUbicacionAccesoMedTradicional(
      int ubicacionId,
      List<LstDificultadAccesoMedTradicional>
          lstDificultadAccesoMedTradicional) async {
    try {
      // First, delete existing records for the given ubicacionId
      await supabase
          .from('asp1_ubicacionaccesomedtradicional')
          .delete()
          .eq('Ubicacion_id', ubicacionId);

      // Prepare the list of records to be inserted
      final ubicacionDificultadesAccesoMedTradicional =
          lstDificultadAccesoMedTradicional
              .map((item) => {
                    'DificultadAccesoMedTrad_id':
                        item.dificultadAccesoMedTradId,
                    'Ubicacion_id': ubicacionId,
                  })
              .toList();

      // Insert the new records
      await supabase
          .from('asp1_ubicacionaccesomedtradicional')
          .upsert(ubicacionDificultadesAccesoMedTradicional);

      // Return the number of rows inserted
      return ubicacionDificultadesAccesoMedTradicional.length;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
