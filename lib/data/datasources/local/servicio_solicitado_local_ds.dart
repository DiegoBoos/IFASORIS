import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/servicio_solicitado.dart';

abstract class ServicioSolicitadoLocalDataSource {
  Future<List<ServicioSolicitadoModel>> getServiciosSolicitados();
  Future<int> saveServicioSolicitado(
      ServicioSolicitadoModel servicioSolicitado);

  Future<List<LstServicioSolicitado>> getLstServiciosSolicitados(
      int? cuidadoSaludCondRiesgoId);

  Future<int> saveServiciosSolicitados(int cuidadoSaludCondRiesgoId,
      List<LstServicioSolicitado> lstServiciosSolicitados);
}

class ServicioSolicitadoLocalDataSourceImpl
    implements ServicioSolicitadoLocalDataSource {
  @override
  Future<List<ServicioSolicitadoModel>> getServiciosSolicitados() async {
    try {
      final res = await supabase
          .from('ServiciosSolicitados_CuidadoSaludCondRiesgo')
          .select();
      final result = List<ServicioSolicitadoModel>.from(
          res.map((m) => ServicioSolicitadoModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveServicioSolicitado(
      ServicioSolicitadoModel servicioSolicitado) async {
    try {
      final res = await supabase
          .from('ServiciosSolicitados_CuidadoSaludCondRiesgo')
          .insert(servicioSolicitado.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<List<LstServicioSolicitado>> getLstServiciosSolicitados(
      int? cuidadoSaludCondRiesgoId) async {
    try {
      final res = await supabase
          .from('Asp5_CuidadoSaludCondRiesgoServiciosSolicita')
          .select()
          .eq('CuidadoSaludCondRiesgo_id', cuidadoSaludCondRiesgoId);
      final result = List<LstServicioSolicitado>.from(
          res.map((m) => LstServicioSolicitado.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveServiciosSolicitados(int cuidadoSaludCondRiesgoId,
      List<LstServicioSolicitado> lstServiciosSolicitados) async {
    try {
      // First, delete existing records for the given cuidadoSaludCondRiesgoId
      await supabase
          .from('Asp5_CuidadoSaludCondRiesgoServiciosSolicita')
          .delete()
          .eq('CuidadoSaludCondRiesgo_id', cuidadoSaludCondRiesgoId);

      // Prepare the list of records to be inserted
      final cuidadoSaludCondRiesgoServiciosSolicitados = lstServiciosSolicitados
          .map((item) => {
                'servicioSolicitadoId': item.servicioSolicitadoId,
                'cuidadoSaludCondRiesgoId': cuidadoSaludCondRiesgoId,
              })
          .toList();

      // Insert the new records
      final res = await supabase
          .from('Asp5_CuidadoSaludCondRiesgoServiciosSolicita')
          .insert(cuidadoSaludCondRiesgoServiciosSolicitados);

      // Return the number of rows inserted
      return res.data != null ? res.data.length : 0;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
