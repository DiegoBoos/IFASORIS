import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/especialidad_med_tradicional.dart';
import '../../models/nombre_med_tradicional.dart';

abstract class EspecialidadMedTradicionalLocalDataSource {
  Future<List<EspecialidadMedTradicionalModel>>
      getEspecialidadesMedTradicional();
  Future<int> saveUbicacionEspecialidadMedTradicional(
      int ubicacionId, List<LstEspMedTradicional> lstEspMedTradicional);
  Future<int> saveUbicacionNombresMedTradicional(
      int ubicacionId, List<LstNombreMedTradicional> lstNombreMedTradicional);
  Future<int> saveEspecialidadesMedTradicionalAtencionSalud(
      int atencionSaludId, List<LstEspMedTradicional> lstEspMedTradicional);
  Future<int> saveEspecialidadMedTradicional(
      EspecialidadMedTradicionalModel especialidadMedTradicional);
  Future<List<LstNombreMedTradicional>> getUbicacionNombresMedTradicional(
      int? ubicacionId);
  Future<List<LstEspMedTradicional>> getUbicacionEspecialidadesMedTradicional(
      int? ubicacionId);
  Future<List<LstEspMedTradicional>>
      getEspecialidadesMedTradicionalAtencionSalud(int? atencionSaludId);
}

class EspecialidadMedTradicionalLocalDataSourceImpl
    implements EspecialidadMedTradicionalLocalDataSource {
  @override
  Future<List<EspecialidadMedTradicionalModel>>
      getEspecialidadesMedTradicional() async {
    try {
      final res = await supabase
          .from('especialidadesmedtrad_accesomedtradicional')
          .select();
      final result = List<EspecialidadMedTradicionalModel>.from(
          res.map((m) => EspecialidadMedTradicionalModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveEspecialidadMedTradicional(
      EspecialidadMedTradicionalModel especialidadMedTradicional) async {
    try {
      await supabase
          .from('especialidadesmedtrad_accesomedtradicional')
          .upsert(especialidadMedTradicional.toJson())
          .select()
          .single();

      return especialidadMedTradicional.especialidadMedTradId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveUbicacionEspecialidadMedTradicional(
      int ubicacionId, List<LstEspMedTradicional> lstEspMedTradicional) async {
    try {
      // Delete existing records for the given ubicacionId
      await supabase
          .from('asp1_ubicacionespecialidadmedtradicional')
          .delete()
          .eq('Ubicacion_id', ubicacionId);

      // Prepare the list of records to be inserted
      final ubicacionEspecialidadesMedTradicional = lstEspMedTradicional
          .map((item) => {
                'EspecialidadMedTrad_id': item.especialidadMedTradId,
                'Ubicacion_id': ubicacionId,
              })
          .toList();

      // Insert the new records
      await supabase
          .from('asp1_ubicacionespecialidadmedtradicional')
          .upsert(ubicacionEspecialidadesMedTradicional);

      // Return the number of rows inserted
      return ubicacionEspecialidadesMedTradicional.length;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveUbicacionNombresMedTradicional(int ubicacionId,
      List<LstNombreMedTradicional> lstNombreMedTradicional) async {
    try {
      // Delete existing records for the given ubicacionId
      await supabase
          .from('asp1_ubicacionnombresmedtradicional')
          .delete()
          .eq('Ubicacion_id', ubicacionId);

      // Prepare the list of records to be inserted
      final ubicacionNombresMedTradicional = lstNombreMedTradicional
          .map((item) => {
                'NombreMedTradicional': item.nombreMedTradicional,
                'Ubicacion_id': ubicacionId,
              })
          .toList();

      // Insert the new records
      await supabase
          .from('asp1_ubicacionnombresmedtradicional')
          .upsert(ubicacionNombresMedTradicional);

      // Return the number of rows inserted
      return lstNombreMedTradicional.length;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveEspecialidadesMedTradicionalAtencionSalud(int atencionSaludId,
      List<LstEspMedTradicional> lstEspMedTradicional) async {
    try {
      // Delete existing records for the given atencionSaludId
      await supabase
          .from('asp7_especialidadesmedtradatencionsalud')
          .delete()
          .eq('AtencionSalud_id', atencionSaludId);

      // Prepare the list of records to be inserted
      final nombresMedTradicionalAtencionSalud = lstEspMedTradicional
          .map((item) => {
                'EspecialidadMedTrad_id': item.especialidadMedTradId,
                'AtencionSalud_id': atencionSaludId,
              })
          .toList();

      // Insert the new records
      await supabase
          .from('asp7_especialidadesmedtradatencionsalud')
          .upsert(nombresMedTradicionalAtencionSalud);

      // Return the number of rows inserted
      return nombresMedTradicionalAtencionSalud.length;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstNombreMedTradicional>> getUbicacionNombresMedTradicional(
      int? ubicacionId) async {
    try {
      final res = await supabase
          .from('asp1_ubicacionnombresmedtradicional')
          .select()
          .eq('Ubicacion_id', ubicacionId);
      final result = List<LstNombreMedTradicional>.from(
          res.map((m) => LstNombreMedTradicional.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstEspMedTradicional>> getUbicacionEspecialidadesMedTradicional(
      int? ubicacionId) async {
    try {
      final res = await supabase
          .from('asp1_ubicacionespecialidadmedtradicional')
          .select()
          .eq('Ubicacion_id', ubicacionId);
      final result = List<LstEspMedTradicional>.from(
          res.map((m) => LstEspMedTradicional.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstEspMedTradicional>>
      getEspecialidadesMedTradicionalAtencionSalud(int? atencionSaludId) async {
    try {
      final res = await supabase
          .from('asp7_especialidadesmedtradatencionsalud')
          .select()
          .eq('AtencionSalud_id', atencionSaludId);
      final result = List<LstEspMedTradicional>.from(
          res.map((m) => LstEspMedTradicional.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
