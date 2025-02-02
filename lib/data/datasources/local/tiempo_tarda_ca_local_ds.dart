import '../../../services/connection_sqlite_service.dart';
import '../../models/tiempo_tarda_ca.dart';

abstract class TiempoTardaCALocalDataSource {
  Future<List<TiempoTardaCAModel>> getTiemposTardaCA();
  Future<int> saveTiempoTardaCA(TiempoTardaCAModel tiempoTardaCA);
}

class TiempoTardaCALocalDataSourceImpl implements TiempoTardaCALocalDataSource {
  @override
  Future<List<TiempoTardaCAModel>> getTiemposTardaCA() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('TiemposTarda_CentroAtencion');
    final result = List<TiempoTardaCAModel>.from(
        res.map((m) => TiempoTardaCAModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTiempoTardaCA(TiempoTardaCAModel tiempoTardaCA) async {
    final db = await ConnectionSQLiteService.db;

    final res =
        await db.insert('TiemposTarda_CentroAtencion', tiempoTardaCA.toJson());

    return res;
  }
}
