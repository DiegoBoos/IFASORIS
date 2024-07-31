import '../../../services/connection_sqlite_service.dart';
import '../../models/actividad_fisica.dart';

abstract class ActividadFisicaLocalDataSource {
  Future<List<ActividadFisicaModel>> getActividadesFisicas();
  Future<int> saveActividadFisica(ActividadFisicaModel actividadFisica);
}

class ActividadFisicaLocalDataSourceImpl
    implements ActividadFisicaLocalDataSource {
  @override
  Future<List<ActividadFisicaModel>> getActividadesFisicas() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('ActividadesFisicas_EstilosVidaSaludable');
    final result = List<ActividadFisicaModel>.from(
        res.map((m) => ActividadFisicaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveActividadFisica(ActividadFisicaModel actividadFisica) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.insert(
        'ActividadesFisicas_EstilosVidaSaludable', actividadFisica.toJson());

    return res;
  }
}
