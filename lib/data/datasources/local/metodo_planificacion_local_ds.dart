import '../../../services/connection_sqlite_service.dart';
import '../../models/metodo_planificacion.dart';

abstract class MetodoPlanificacionLocalDataSource {
  Future<List<MetodoPlanificacionModel>> getMetodosPlanificacion();
  Future<int> saveMetodoPlanificacion(
      MetodoPlanificacionModel metodoPlanificacion);
}

class MetodoPlanificacionLocalDataSourceImpl
    implements MetodoPlanificacionLocalDataSource {
  @override
  Future<List<MetodoPlanificacionModel>> getMetodosPlanificacion() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('MetodosPlanificacion_CuidadoSaludCondRiesgo');
    final result = List<MetodoPlanificacionModel>.from(
        res.map((m) => MetodoPlanificacionModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveMetodoPlanificacion(
      MetodoPlanificacionModel metodoPlanificacion) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('MetodosPlanificacion_CuidadoSaludCondRiesgo',
        metodoPlanificacion.toJson());

    return res;
  }
}
