import '../../../domain/entities/lugar_vacunacion_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/lugar_vacunacion_model.dart';

abstract class LugarVacunacionLocalDataSource {
  Future<List<LugarVacunacionModel>> getLugaresVacunacion();
  Future<int> saveLugarVacunacion(LugarVacunacionEntity lugarVacunacion);
}

class LugarVacunacionLocalDataSourceImpl
    implements LugarVacunacionLocalDataSource {
  @override
  Future<List<LugarVacunacionModel>> getLugaresVacunacion() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('LugaresVacunacion_CuidadoSaludCondRiesgo');
    final result = List<LugarVacunacionModel>.from(
        res.map((m) => LugarVacunacionModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveLugarVacunacion(LugarVacunacionEntity lugarVacunacion) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'LugaresVacunacion_CuidadoSaludCondRiesgo', lugarVacunacion.toJson());

    return res;
  }
}
