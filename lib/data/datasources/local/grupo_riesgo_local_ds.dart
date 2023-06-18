import '../../../domain/entities/grupo_riesgo_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/grupo_riesgo_model.dart';

abstract class GrupoRiesgoLocalDataSource {
  Future<List<GrupoRiesgoModel>> getGruposRiesgo();
  Future<int> saveGrupoRiesgo(GrupoRiesgoEntity grupoRiesgo);
}

class GrupoRiesgoLocalDataSourceImpl implements GrupoRiesgoLocalDataSource {
  @override
  Future<List<GrupoRiesgoModel>> getGruposRiesgo() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('GruposRiesgo_CentroAtencion');
    final result = List<GrupoRiesgoModel>.from(
        res.map((m) => GrupoRiesgoModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveGrupoRiesgo(GrupoRiesgoEntity grupoRiesgo) async {
    final db = await ConnectionSQLiteService.db;

    final res =
        await db.insert('GruposRiesgo_CentroAtencion', grupoRiesgo.toJson());

    return res;
  }
}
