import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/actividad_fisica.dart';

abstract class ActividadFisicaLocalDataSource {
  Future<List<ActividadFisicaModel>> getActividadesFisicas();
  Future<int> saveActividadFisica(ActividadFisicaModel actividadFisica);
}

class ActividadFisicaLocalDataSourceImpl
    implements ActividadFisicaLocalDataSource {
  @override
  Future<List<ActividadFisicaModel>> getActividadesFisicas() async {
    try {
      final res = await supabase
          .from('actividadesfisicas_estilosvidasaludable')
          .select();
      final result = List<ActividadFisicaModel>.from(
          res.map((m) => ActividadFisicaModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveActividadFisica(ActividadFisicaModel actividadFisica) async {
    try {
      await supabase
          .from('actividadesfisicas_estilosvidasaludable')
          .upsert(actividadFisica.toJson());

      return actividadFisica.actividadFisicaId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
