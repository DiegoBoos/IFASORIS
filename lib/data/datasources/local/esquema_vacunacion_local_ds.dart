import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/esquema_vacunacion.dart';

abstract class EsquemaVacunacionLocalDataSource {
  Future<List<EsquemaVacunacionModel>> getEsquemasVacunacion();
  Future<int> saveEsquemaVacunacion(EsquemaVacunacionModel esquemaVacunacion);
}

class EsquemaVacunacionLocalDataSourceImpl
    implements EsquemaVacunacionLocalDataSource {
  @override
  Future<List<EsquemaVacunacionModel>> getEsquemasVacunacion() async {
    try {
      final res = await supabase
          .from('EsquemasVacunacion_CuidadoSaludCondRiesgo')
          .select();
      final result = List<EsquemaVacunacionModel>.from(
          res.map((m) => EsquemaVacunacionModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveEsquemaVacunacion(
      EsquemaVacunacionModel esquemaVacunacion) async {
    try {
      final res = await supabase
          .from('EsquemasVacunacion_CuidadoSaludCondRiesgo')
          .insert(esquemaVacunacion.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
