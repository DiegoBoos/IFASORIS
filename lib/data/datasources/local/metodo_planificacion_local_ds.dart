import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/metodo_planificacion.dart';

abstract class MetodoPlanificacionLocalDataSource {
  Future<List<MetodoPlanificacionModel>> getMetodosPlanificacion();
  Future<int> saveMetodoPlanificacion(
      MetodoPlanificacionModel metodoPlanificacion);
}

class MetodoPlanificacionLocalDataSourceImpl
    implements MetodoPlanificacionLocalDataSource {
  @override
  Future<List<MetodoPlanificacionModel>> getMetodosPlanificacion() async {
    try {
      final res = await supabase
          .from('metodosplanificacion_cuidadosaludcondriesgo')
          .select();
      final result = List<MetodoPlanificacionModel>.from(
          res.map((m) => MetodoPlanificacionModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveMetodoPlanificacion(
      MetodoPlanificacionModel metodoPlanificacion) async {
    try {
      await supabase
          .from('metodosplanificacion_cuidadosaludcondriesgo')
          .upsert(metodoPlanificacion.toJson());

      return metodoPlanificacion.metodoPlanificacionId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
