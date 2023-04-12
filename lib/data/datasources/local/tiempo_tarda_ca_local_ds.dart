import '../../../domain/entities/tiempo_tarda_ca_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/tiempo_tarda_ca_model.dart';

abstract class TiempoTardaCALocalDataSource {
  Future<List<TiempoTardaCAModel>> getTiemposTardaCA();
  Future<int> saveTiempoTardaCA(TiempoTardaCAEntity tiempoTardaCA);
}

class TiempoTardaCALocalDataSourceImpl implements TiempoTardaCALocalDataSource {
  @override
  Future<List<TiempoTardaCAModel>> getTiemposTardaCA() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('TiempoTardaCA');
    final result = List<TiempoTardaCAModel>.from(
        res.map((m) => TiempoTardaCAModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTiempoTardaCA(TiempoTardaCAEntity tiempoTardaCA) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('TiempoTardaCA', tiempoTardaCA.toJson());

    return res;
  }
}
