import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/autoridad_indigena.dart';

abstract class AutoridadIndigenaLocalDataSource {
  Future<List<AutoridadIndigenaModel>> getAutoridadesIndigenas();
  Future<int> saveAutoridadIndigena(AutoridadIndigenaModel autoridadIndigena);
}

class AutoridadIndigenaLocalDataSourceImpl
    implements AutoridadIndigenaLocalDataSource {
  @override
  Future<List<AutoridadIndigenaModel>> getAutoridadesIndigenas() async {
    try {
      final res =
          await supabase.from('AutoridadesIndigenas_DatosVivienda').select();
      final result = List<AutoridadIndigenaModel>.from(
          res.map((m) => AutoridadIndigenaModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveAutoridadIndigena(
      AutoridadIndigenaModel autoridadIndigena) async {
    try {
      final res = await supabase
          .from('AutoridadesIndigenas_DatosVivienda')
          .insert(autoridadIndigena.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
