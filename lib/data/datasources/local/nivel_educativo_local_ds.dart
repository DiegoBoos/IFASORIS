import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/nivel_educativo.dart';

abstract class NivelEducativoLocalDataSource {
  Future<List<NivelEducativoModel>> getNivelesEducativos();
  Future<int> saveNivelEducativo(NivelEducativoModel nivelEducativo);
}

class NivelEducativoLocalDataSourceImpl
    implements NivelEducativoLocalDataSource {
  @override
  Future<List<NivelEducativoModel>> getNivelesEducativos() async {
    try {
      final res = await supabase.from('NivelEducativo_GrupoFamiliar').select();
      final result = List<NivelEducativoModel>.from(
          res.map((m) => NivelEducativoModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveNivelEducativo(NivelEducativoModel nivelEducativo) async {
    try {
      final res = await supabase
          .from('NivelEducativo_GrupoFamiliar')
          .insert(nivelEducativo.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
