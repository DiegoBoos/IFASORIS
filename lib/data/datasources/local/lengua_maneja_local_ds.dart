import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/lengua_maneja.dart';

abstract class LenguaManejaLocalDataSource {
  Future<List<LenguaManejaModel>> getLenguasManeja();
  Future<int> saveLenguaManeja(LenguaManejaModel lenguaManeja);
}

class LenguaManejaLocalDataSourceImpl implements LenguaManejaLocalDataSource {
  @override
  Future<List<LenguaManejaModel>> getLenguasManeja() async {
    try {
      final res = await supabase.from('LenguaManeja_GrupoFamiliar').select();
      final result = List<LenguaManejaModel>.from(
          res.map((m) => LenguaManejaModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveLenguaManeja(LenguaManejaModel lenguaManeja) async {
    try {
      final res = await supabase
          .from('LenguaManeja_GrupoFamiliar')
          .insert(lenguaManeja.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
