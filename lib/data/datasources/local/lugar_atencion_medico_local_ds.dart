import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/lugar_atencion_medico.dart';

abstract class LugarAtencionMedicoLocalDataSource {
  Future<List<LugarAtencionMedicoModel>> getLugaresAtencionMedico();
  Future<int> saveLugarAtencionMedico(
      LugarAtencionMedicoModel lugarAtencionMedico);
  Future<List<LstLugarAtencionMedico>> getLugaresAtencionMedicoAtencionSalud(
      int? atencionSaludId);
  Future<int> saveLugaresAtencionMedicoAtencionSalud(
      int atencionSaludId, List<LstLugarAtencionMedico> lstLugarAtencionMedico);
}

class LugarAtencionMedicoLocalDataSourceImpl
    implements LugarAtencionMedicoLocalDataSource {
  @override
  Future<List<LugarAtencionMedicoModel>> getLugaresAtencionMedico() async {
    try {
      final res =
          await supabase.from('lugaresatencionmedico_atencionsalud').select();
      final result = List<LugarAtencionMedicoModel>.from(
          res.map((m) => LugarAtencionMedicoModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveLugarAtencionMedico(
      LugarAtencionMedicoModel lugarAtencionMedico) async {
    try {
      await supabase
          .from('lugaresatencionmedico_atencionsalud')
          .upsert(lugarAtencionMedico.toJson());

      return lugarAtencionMedico.lugarAtencionMedicoId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstLugarAtencionMedico>> getLugaresAtencionMedicoAtencionSalud(
      int? atencionSaludId) async {
    try {
      final res = await supabase
          .from('asp7_lugaresatencionatencionsalud')
          .select()
          .eq('AtencionSalud_id', atencionSaludId);
      final result = List<LstLugarAtencionMedico>.from(
          res.map((m) => LstLugarAtencionMedico.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveLugaresAtencionMedicoAtencionSalud(int atencionSaludId,
      List<LstLugarAtencionMedico> lstLugarAtencionMedico) async {
    try {
      // First, delete existing records for the given atencionSaludId
      await supabase
          .from('asp7_lugaresatencionatencionsalud')
          .delete()
          .eq('AtencionSalud_id', atencionSaludId);

      // Prepare the list of records to be inserted
      final lugaresAtencionMedicoAtencionSalud = lstLugarAtencionMedico
          .map((item) => {
                'lugarAtencionMedicoId': item.lugarAtencionMedicoId,
                'atencionSaludId': atencionSaludId,
              })
          .toList();

      // Insert the new records
      final res = await supabase
          .from('asp7_lugaresatencionatencionsalud')
          .upsert(lugaresAtencionMedicoAtencionSalud);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
