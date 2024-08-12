import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/regimen.dart';

abstract class RegimenLocalDataSource {
  Future<List<RegimenModel>> getRegimenes();
  Future<int> saveRegimen(RegimenModel regimen);
}

class RegimenLocalDataSourceImpl implements RegimenLocalDataSource {
  @override
  Future<List<RegimenModel>> getRegimenes() async {
    try {
      final res = await supabase.from('Regimenes_GrupoFamiliar').select();
      final result =
          List<RegimenModel>.from(res.map((m) => RegimenModel.fromJson(m)))
              .toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveRegimen(RegimenModel regimen) async {
    try {
      final res = await supabase
          .from('Regimenes_GrupoFamiliar')
          .insert(regimen.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
