import '../../../services/connection_sqlite_service.dart';
import '../../models/alimentacion.dart';

abstract class AlimentacionLocalDataSource {
  Future<List<AlimentacionModel>> getAlimentaciones();
  Future<int> saveAlimentacion(AlimentacionModel alimentacion);
}

class AlimentacionLocalDataSourceImpl implements AlimentacionLocalDataSource {
  @override
  Future<List<AlimentacionModel>> getAlimentaciones() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Alimentacion_EstilosVidaSaludable');
    final result = List<AlimentacionModel>.from(
        res.map((m) => AlimentacionModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveAlimentacion(AlimentacionModel alimentacion) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'Alimentacion_EstilosVidaSaludable', alimentacion.toJson());

    return res;
  }
}
