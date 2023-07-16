import '../../../domain/entities/actividad_fisica_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/actividad_fisica_model.dart';

abstract class ActividadFisicaLocalDataSource {
  Future<List<ActividadFisicaModel>> getActividadesFisicas();
  Future<int> saveActividadFisica(ActividadFisicaEntity actividadFisica);
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
  Future<int> saveActividadFisica(ActividadFisicaEntity actividadFisica) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'ActividadesFisicas_EstilosVidaSaludable', actividadFisica.toJson());

    return res;
  }
}
