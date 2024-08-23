import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/nombre_enfermedad.dart';

abstract class NombreEnfermedadLocalDataSource {
  Future<List<NombreEnfermedadModel>> getNombresEnfermedades();
  Future<int> saveNombreEnfermedad(NombreEnfermedadModel nombreEnfermedad);
  Future<List<LstNombreEnfermedad>> getLstNombresEnfermedades(
      int? cuidadoSaludCondRiesgoId);
  Future<int> saveNombresEnfermedades(int cuidadoSaludCondRiesgoId,
      List<LstNombreEnfermedad> lstNombresEnfermedades);
}

class NombreEnfermedadLocalDataSourceImpl
    implements NombreEnfermedadLocalDataSource {
  @override
  Future<List<NombreEnfermedadModel>> getNombresEnfermedades() async {
    try {
      final res = await supabase
          .from('nombresenfermedad_cuidadosaludcondriesgo')
          .select();
      final result = List<NombreEnfermedadModel>.from(
          res.map((m) => NombreEnfermedadModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveNombreEnfermedad(
      NombreEnfermedadModel nombreEnfermedad) async {
    try {
      await supabase
          .from('nombresenfermedad_cuidadosaludcondriesgo')
          .upsert(nombreEnfermedad.toJson());

      return nombreEnfermedad.nombreEnfermedadId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstNombreEnfermedad>> getLstNombresEnfermedades(
      int? cuidadoSaludCondRiesgoId) async {
    try {
      final res = await supabase
          .from('asp5_cuidadosaludcondriesgonombresenfermedad')
          .select()
          .eq('CuidadoSaludCondRiesgo_id', cuidadoSaludCondRiesgoId);

      final result = List<LstNombreEnfermedad>.from(
          res.map((m) => LstNombreEnfermedad.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveNombresEnfermedades(int cuidadoSaludCondRiesgoId,
      List<LstNombreEnfermedad> lstNombresEnfermedades) async {
    try {
      // First, delete existing records for the given cuidadoSaludCondRiesgoId
      await supabase
          .from('asp5_cuidadosaludcondriesgonombresenfermedad')
          .delete()
          .eq('CuidadoSaludCondRiesgo_id', cuidadoSaludCondRiesgoId);

      // Prepare the list of records to be inserted
      final cuidadoSaludCondRiesgoNombresEnfermedades = lstNombresEnfermedades
          .map((item) => {
                'NombreEnfermedad_id': item.nombreEnfermedadId,
                'CuidadoSaludCondRiesgo_id': cuidadoSaludCondRiesgoId,
              })
          .toList();

      // Insert the new records
      await supabase
          .from('asp5_cuidadosaludcondriesgonombresenfermedad')
          .upsert(cuidadoSaludCondRiesgoNombresEnfermedades);

      // Return the number of rows inserted
      return cuidadoSaludCondRiesgoNombresEnfermedades.length;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
