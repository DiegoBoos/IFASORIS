import '../../../services/connection_sqlite_service.dart';
import '../../models/esquema_vacunacion.dart';

abstract class EsquemaVacunacionLocalDataSource {
  Future<List<EsquemaVacunacionModel>> getEsquemasVacunacion();
  Future<int> saveEsquemaVacunacion(EsquemaVacunacionModel esquemaVacunacion);
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
      EsquemaVacunacionModel esquemaVacunacion) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('EsquemasVacunacion_CuidadoSaludCondRiesgo',
        esquemaVacunacion.toJson());

    return res;
  }
}
