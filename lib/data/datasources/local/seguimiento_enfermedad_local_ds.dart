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
          .from('SeguimientoEnfermedades_CuidadoSaludCondRiesgo')
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
      final res = await supabase
          .from('SeguimientoEnfermedades_CuidadoSaludCondRiesgo')
          .insert(seguimientoEnfermedad.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
