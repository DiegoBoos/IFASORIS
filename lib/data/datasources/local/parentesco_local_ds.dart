import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/parentesco.dart';

abstract class ParentescoLocalDataSource {
  Future<List<ParentescoModel>> getParentescos();
  Future<int> saveParentesco(ParentescoModel parentesco);
}

class ParentescoLocalDataSourceImpl implements ParentescoLocalDataSource {
  @override
  Future<List<ParentescoModel>> getParentescos() async {
    try {
      final res = await supabase.from('parentesco_grupofamiliar').select();
      final result = List<ParentescoModel>.from(
          res.map((m) => ParentescoModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveParentesco(ParentescoModel parentesco) async {
    try {
      await supabase
          .from('parentesco_grupofamiliar')
          .upsert(parentesco.toJson());

      return parentesco.parentescoId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
