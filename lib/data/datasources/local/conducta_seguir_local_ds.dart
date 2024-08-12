import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/conducta_seguir.dart';

abstract class ConductaSeguirLocalDataSource {
  Future<List<ConductaSeguirModel>> getConductasSeguir();
  Future<int> saveConductaSeguir(ConductaSeguirModel conductaSeguir);
}

class ConductaSeguirLocalDataSourceImpl
    implements ConductaSeguirLocalDataSource {
  @override
  Future<List<ConductaSeguirModel>> getConductasSeguir() async {
    try {
      final res = await supabase
          .from('ConductasSeguir_CuidadoSaludCondRiesgo')
          .select();
      final result = List<ConductaSeguirModel>.from(
          res.map((m) => ConductaSeguirModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveConductaSeguir(ConductaSeguirModel conductaSeguir) async {
    try {
      final res = await supabase
          .from('ConductasSeguir_CuidadoSaludCondRiesgo')
          .insert(conductaSeguir.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
