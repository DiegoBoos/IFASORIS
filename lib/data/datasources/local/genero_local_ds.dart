import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/genero.dart';

abstract class GeneroLocalDataSource {
  Future<List<GeneroModel>> getGeneros();
  Future<int> saveGenero(GeneroModel genero);
}

class GeneroLocalDataSourceImpl implements GeneroLocalDataSource {
  @override
  Future<List<GeneroModel>> getGeneros() async {
    try {
      final res = await supabase.from('genero_grupofamiliar').select();
      final result =
          List<GeneroModel>.from(res.map((m) => GeneroModel.fromJson(m)))
              .toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveGenero(GeneroModel genero) async {
    try {
      await supabase.from('genero_grupofamiliar').upsert(genero.toJson());

      return genero.generoId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
