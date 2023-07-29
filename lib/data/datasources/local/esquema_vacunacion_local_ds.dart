import '../../../domain/entities/esquema_vacunacion_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/esquema_vacunacion_model.dart';

abstract class EsquemaVacunacionLocalDataSource {
  Future<List<EsquemaVacunacionModel>> getEsquemasVacunacion();
  Future<int> saveEsquemaVacunacion(EsquemaVacunacionEntity esquemaVacunacion);
}

class EsquemaVacunacionLocalDataSourceImpl
    implements EsquemaVacunacionLocalDataSource {
  @override
  Future<List<EsquemaVacunacionModel>> getEsquemasVacunacion() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('EsquemasVacunacion_CuidadoSaludCondRiesgo');
    final result = List<EsquemaVacunacionModel>.from(
        res.map((m) => EsquemaVacunacionModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveEsquemaVacunacion(
      EsquemaVacunacionEntity esquemaVacunacion) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('EsquemasVacunacion_CuidadoSaludCondRiesgo',
        esquemaVacunacion.toJson());

    return res;
  }
}
