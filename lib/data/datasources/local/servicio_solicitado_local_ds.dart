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
          .from('serviciossolicitados_cuidadosaludcondriesgo')
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
      await supabase
          .from('serviciossolicitados_cuidadosaludcondriesgo')
          .upsert(servicioSolicitado.toJson());

      return servicioSolicitado.servicioSolicitadoId!;
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
          .from('asp5_cuidadosaludcondriesgoserviciossolicita')
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
          .from('asp5_cuidadosaludcondriesgoserviciossolicita')
          .delete()
          .eq('CuidadoSaludCondRiesgo_id', cuidadoSaludCondRiesgoId);

      // Prepare the list of records to be inserted
      final cuidadoSaludCondRiesgoServiciosSolicitados = lstServiciosSolicitados
          .map((item) => {
                'ServicioSolicitado_id': item.servicioSolicitadoId,
                'CuidadoSaludCondRiesgo_id': cuidadoSaludCondRiesgoId,
              })
          .toList();

      // Insert the new records
      await supabase
          .from('asp5_cuidadosaludcondriesgoserviciossolicita')
          .upsert(cuidadoSaludCondRiesgoServiciosSolicitados);

      // Return the number of rows inserted
      return cuidadoSaludCondRiesgoServiciosSolicitados.length;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
