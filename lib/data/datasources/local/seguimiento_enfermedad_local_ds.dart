import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/seguimiento_enfermedad.dart';

abstract class SeguimientoEnfermedadLocalDataSource {
  Future<List<SeguimientoEnfermedadModel>> getSeguimientoEnfermedades();
  Future<int> saveSeguimientoEnfermedad(
      SeguimientoEnfermedadModel seguimientoEnfermedad);
}

class SeguimientoEnfermedadLocalDataSourceImpl
    implements SeguimientoEnfermedadLocalDataSource {
  @override
  Future<List<SeguimientoEnfermedadModel>> getSeguimientoEnfermedades() async {
    try {
      final res = await supabase
          .from('seguimientoenfermedades_cuidadosaludcondriesgo')
          .select();
      final result = List<SeguimientoEnfermedadModel>.from(
          res.map((m) => SeguimientoEnfermedadModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveSeguimientoEnfermedad(
      SeguimientoEnfermedadModel seguimientoEnfermedad) async {
    try {
      await supabase
          .from('seguimientoenfermedades_cuidadosaludcondriesgo')
          .upsert(seguimientoEnfermedad.toJson());

      return seguimientoEnfermedad.seguimientoEnfermedadId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
