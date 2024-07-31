import '../../../services/connection_sqlite_service.dart';
import '../../models/lugar_planta_medicinal.dart';

abstract class LugarPlantaMedicinalLocalDataSource {
  Future<List<LugarPlantaMedicinalModel>> getLugaresPlantasMedicinales();
  Future<int> saveLugarPlantaMedicinal(
      LugarPlantaMedicinalModel lugarPlantaMedicinal);
}

class LugarPlantaMedicinalLocalDataSourceImpl
    implements LugarPlantaMedicinalLocalDataSource {
  @override
  Future<List<LugarPlantaMedicinalModel>> getLugaresPlantasMedicinales() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('LugaresPlantasMedicinales_AtencionSalud');
    final result = List<LugarPlantaMedicinalModel>.from(
        res.map((m) => LugarPlantaMedicinalModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveLugarPlantaMedicinal(
      LugarPlantaMedicinalModel lugarPlantaMedicinal) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('LugaresPlantasMedicinales_AtencionSalud',
        lugarPlantaMedicinal.toJson());

    return res;
  }
}
