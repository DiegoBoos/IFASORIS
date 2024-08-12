import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/condicion_nutricional.dart';

abstract class CondicionNutricionalLocalDataSource {
  Future<List<CondicionNutricionalModel>> getCondicionesNutricionales();
  Future<int> saveCondicionNutricional(
      CondicionNutricionalModel condicionNutricional);
}

class CondicionNutricionalLocalDataSourceImpl
    implements CondicionNutricionalLocalDataSource {
  @override
  Future<List<CondicionNutricionalModel>> getCondicionesNutricionales() async {
    try {
      final res = await supabase
          .from('CondicionesNutricionales_CuidadoSaludCondRiesgo')
          .select();
      final result = List<CondicionNutricionalModel>.from(
          res.map((m) => CondicionNutricionalModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure(
          ['Error al obtener condiciones nutricionales']);
    }
  }

  @override
  Future<int> saveCondicionNutricional(
      CondicionNutricionalModel condicionNutricional) async {
    try {
      final res = await supabase
          .from('CondicionesNutricionales_CuidadoSaludCondRiesgo')
          .insert(condicionNutricional.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
