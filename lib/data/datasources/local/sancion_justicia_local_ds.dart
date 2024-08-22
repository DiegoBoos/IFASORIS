import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/sancion_justicia.dart';

abstract class SancionJusticiaLocalDataSource {
  Future<List<SancionJusticiaModel>> getSancionesJusticia();
  Future<int> saveSancionJusticia(SancionJusticiaModel sancionJusticia);
}

class SancionJusticiaLocalDataSourceImpl
    implements SancionJusticiaLocalDataSource {
  @override
  Future<List<SancionJusticiaModel>> getSancionesJusticia() async {
    try {
      final res = await supabase
          .from('sancionesjusticia_dimsocioculturalpueblosindigenas')
          .select();
      final result = List<SancionJusticiaModel>.from(
          res.map((m) => SancionJusticiaModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveSancionJusticia(SancionJusticiaModel sancionJusticia) async {
    try {
      await supabase
          .from('sancionesjusticia_dimsocioculturalpueblosindigenas')
          .upsert(sancionJusticia.toJson());

      return sancionJusticia.sancionJusticiaId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
