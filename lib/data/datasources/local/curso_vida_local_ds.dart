import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/curso_vida.dart';

abstract class CursoVidaLocalDataSource {
  Future<List<CursoVidaModel>> getCursosVida();
  Future<int> saveCursoVida(CursoVidaModel cursoVida);
}

class CursoVidaLocalDataSourceImpl implements CursoVidaLocalDataSource {
  @override
  Future<List<CursoVidaModel>> getCursosVida() async {
    try {
      final res = await supabase.from('cursovida_grupofamiliar').select();
      final result =
          List<CursoVidaModel>.from(res.map((m) => CursoVidaModel.fromJson(m)))
              .toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveCursoVida(CursoVidaModel cursoVida) async {
    try {
      await supabase.from('cursovida_grupofamiliar').upsert(cursoVida.toJson());

      return cursoVida.cursoVidaId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
