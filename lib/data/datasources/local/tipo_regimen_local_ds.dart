import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/tipo_regimen.dart';

abstract class TipoRegimenLocalDataSource {
  Future<List<TipoRegimenModel>> getTipoRegimenes();
  Future<int> saveTipoRegimen(TipoRegimenModel tiporegimen);
}

class TipoRegimenLocalDataSourceImpl implements TipoRegimenLocalDataSource {
  @override
  Future<List<TipoRegimenModel>> getTipoRegimenes() async {
    try {
      final res = await supabase.from('tiposregimen_grupofamiliar').select();
      final result = List<TipoRegimenModel>.from(
          res.map((m) => TipoRegimenModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveTipoRegimen(TipoRegimenModel tiporegimen) async {
    try {
      await supabase
          .from('tiposregimen_grupofamiliar')
          .upsert(tiporegimen.toJson());

      return tiporegimen.regimenId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
