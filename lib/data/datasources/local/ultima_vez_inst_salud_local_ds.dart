import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/ultima_vez_inst_salud.dart';

abstract class UltimaVezInstSaludLocalDataSource {
  Future<List<UltimaVezInstSaludModel>> getUltimasVecesInstSalud();
  Future<int> saveUltimaVezInstSalud(
      UltimaVezInstSaludModel ultimaVezInstSalud);
}

class UltimaVezInstSaludLocalDataSourceImpl
    implements UltimaVezInstSaludLocalDataSource {
  @override
  Future<List<UltimaVezInstSaludModel>> getUltimasVecesInstSalud() async {
    try {
      final res = await supabase
          .from('UltimaVezInstSalud_CuidadoSaludCondRiesgo')
          .select();
      final result = List<UltimaVezInstSaludModel>.from(
          res.map((m) => UltimaVezInstSaludModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveUltimaVezInstSalud(
      UltimaVezInstSaludModel ultimaVezInstSalud) async {
    try {
      final res = await supabase
          .from('UltimaVezInstSalud_CuidadoSaludCondRiesgo')
          .insert(ultimaVezInstSalud.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
