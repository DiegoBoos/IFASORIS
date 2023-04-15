import '../../../domain/entities/estado_via_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/estado_via_model.dart';

abstract class EstadoViaLocalDataSource {
  Future<List<EstadoViaModel>> getEstadosVias();
  Future<int> saveEstadoVia(EstadoViaEntity estadoVia);
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
  Future<int> saveEstadoVia(EstadoViaEntity estadoVia) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('EstadoVias', estadoVia.toJson());

    return res;
  }
}
