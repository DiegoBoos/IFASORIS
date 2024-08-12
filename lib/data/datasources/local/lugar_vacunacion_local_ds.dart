import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/lugar_vacunacion.dart';

abstract class LugarVacunacionLocalDataSource {
  Future<List<LugarVacunacionModel>> getLugaresVacunacion();
  Future<int> saveLugarVacunacion(LugarVacunacionModel lugarVacunacion);
}

class LugarVacunacionLocalDataSourceImpl
    implements LugarVacunacionLocalDataSource {
  @override
  Future<List<LugarVacunacionModel>> getLugaresVacunacion() async {
    try {
      final res = await supabase
          .from('LugaresVacunacion_CuidadoSaludCondRiesgo')
          .select();
      final result = List<LugarVacunacionModel>.from(
          res.map((m) => LugarVacunacionModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveLugarVacunacion(LugarVacunacionModel lugarVacunacion) async {
    try {
      final res = await supabase
          .from('LugaresVacunacion_CuidadoSaludCondRiesgo')
          .insert(lugarVacunacion.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
