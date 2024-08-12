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
          .from('EspecialidadesMedTrad_AccesoMedTradicional')
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
  Future<int> saveUbicacionEspecialidadMedTradicional(
      int ubicacionId, List<LstEspMedTradicional> lstEspMedTradicional) async {
    try {
      // Delete existing records for the given ubicacionId
      await supabase
          .from('Asp1_UbicacionEspecialidadMedTradicional')
          .delete()
          .eq('Ubicacion_id', ubicacionId);

      // Prepare the list of records to be inserted
      final ubicacionEspecialidadesMedTradicional = lstEspMedTradicional
          .map((item) => {
                'especialidadMedTradicionalId': item.especialidadMedTradId,
                'ubicacionId': ubicacionId,
              })
          .toList();

      // Insert the new records
      final res = await supabase
          .from('Asp1_UbicacionEspecialidadMedTradicional')
          .insert(ubicacionEspecialidadesMedTradicional);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
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
          .from('Asp1_UbicacionNombresMedTradicional')
          .delete()
          .eq('Ubicacion_id', ubicacionId);

      // Prepare the list of records to be inserted
      final ubicacionNombresMedTradicional = lstNombreMedTradicional
          .map((item) => {
                'nombreMedTradicional': item.nombreMedTradicional,
                'ubicacionId': ubicacionId,
              })
          .toList();

      // Insert the new records
      final res = await supabase
          .from('Asp1_UbicacionNombresMedTradicional')
          .insert(ubicacionNombresMedTradicional);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
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
          .from('Asp7_EspecialidadesMedTradAtencionSalud')
          .delete()
          .eq('AtencionSalud_id', atencionSaludId);

      // Prepare the list of records to be inserted
      final nombresMedTradicionalAtencionSalud = lstEspMedTradicional
          .map((item) => {
                'especialidadMedTradId': item.especialidadMedTradId,
                'atencionSaludId': atencionSaludId,
              })
          .toList();

      // Insert the new records
      final res = await supabase
          .from('Asp7_EspecialidadesMedTradAtencionSalud')
          .insert(nombresMedTradicionalAtencionSalud);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
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
      final res = await supabase
          .from('EspecialidadesMedTrad_AccesoMedTradicional')
          .insert(especialidadMedTradicional.toJson());

      return res;
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
          .from('Asp1_UbicacionNombresMedTradicional')
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
          .from('Asp1_UbicacionEspecialidadMedTradicional')
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
          .from('Asp7_EspecialidadesMedTradAtencionSalud')
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
