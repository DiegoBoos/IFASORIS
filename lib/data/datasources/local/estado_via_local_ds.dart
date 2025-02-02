import '../../../services/connection_sqlite_service.dart';
import '../../models/estado_via.dart';

abstract class EstadoViaLocalDataSource {
  Future<List<EstadoViaModel>> getEstadosVias();
  Future<int> saveEstadoVia(EstadoViaModel estadoVia);
}

class EstadoViaLocalDataSourceImpl implements EstadoViaLocalDataSource {
  @override
  Future<List<EstadoViaModel>> getEstadosVias() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('EstadoVias');
    final result =
        List<EstadoViaModel>.from(res.map((m) => EstadoViaModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveEstadoVia(EstadoViaModel estadoVia) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('EstadoVias', estadoVia.toJson());

    return res;
  }
}
