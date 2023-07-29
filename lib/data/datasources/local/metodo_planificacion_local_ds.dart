import '../../../domain/entities/metodo_planificacion_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/metodo_planificacion_model.dart';

abstract class MetodoPlanificacionLocalDataSource {
  Future<List<MetodoPlanificacionModel>> getMetodosPlanificacion();
  Future<int> saveMetodoPlanificacion(
      MetodoPlanificacionEntity metodoPlanificacion);
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
      MetodoPlanificacionEntity metodoPlanificacion) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('MetodosPlanificacion_CuidadoSaludCondRiesgo',
        metodoPlanificacion.toJson());

    return res;
  }
}
