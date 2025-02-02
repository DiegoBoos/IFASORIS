import '../../../services/connection_sqlite_service.dart';
import '../../models/grupo_riesgo.dart';

abstract class GrupoRiesgoLocalDataSource {
  Future<List<GrupoRiesgoModel>> getGruposRiesgo();
  Future<int> saveGrupoRiesgo(GrupoRiesgoModel grupoRiesgo);
}

class GrupoRiesgoLocalDataSourceImpl implements GrupoRiesgoLocalDataSource {
  @override
  Future<List<GrupoRiesgoModel>> getGruposRiesgo() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('GrupoRiesgo_GrupoFamiliar');
    final result = List<GrupoRiesgoModel>.from(
        res.map((m) => GrupoRiesgoModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveGrupoRiesgo(GrupoRiesgoModel grupoRiesgo) async {
    final db = await ConnectionSQLiteService.db;

    final res =
        await db.insert('GrupoRiesgo_GrupoFamiliar', grupoRiesgo.toJson());

    return res;
  }
}
