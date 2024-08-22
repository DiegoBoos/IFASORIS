import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/tipo_calendario.dart';

abstract class TipoCalendarioLocalDataSource {
  Future<List<TipoCalendarioModel>> getTiposCalendario();
  Future<int> saveTipoCalendario(TipoCalendarioModel tipoCalendario);
}

class TipoCalendarioLocalDataSourceImpl
    implements TipoCalendarioLocalDataSource {
  @override
  Future<List<TipoCalendarioModel>> getTiposCalendario() async {
    try {
      final res = await supabase
          .from('tiposcalendarios_aspectossocioeconomicos')
          .select();
      final result = List<TipoCalendarioModel>.from(
          res.map((m) => TipoCalendarioModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveTipoCalendario(TipoCalendarioModel tipoCalendario) async {
    try {
      await supabase
          .from('tiposcalendarios_aspectossocioeconomicos')
          .upsert(tipoCalendario.toJson());

      return tipoCalendario.tipoCalendarioId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
