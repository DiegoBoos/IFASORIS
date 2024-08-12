import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/grupo_riesgo.dart';

abstract class GrupoRiesgoLocalDataSource {
  Future<List<GrupoRiesgoModel>> getGruposRiesgo();
  Future<int> saveGrupoRiesgo(GrupoRiesgoModel grupoRiesgo);
}

class GrupoRiesgoLocalDataSourceImpl implements GrupoRiesgoLocalDataSource {
  @override
  Future<List<GrupoRiesgoModel>> getGruposRiesgo() async {
    try {
      final res = await supabase.from('GrupoRiesgo_GrupoFamiliar').select();
      final result = List<GrupoRiesgoModel>.from(
          res.map((m) => GrupoRiesgoModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveGrupoRiesgo(GrupoRiesgoModel grupoRiesgo) async {
    try {
      final res = await supabase
          .from('GrupoRiesgo_GrupoFamiliar')
          .insert(grupoRiesgo.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
