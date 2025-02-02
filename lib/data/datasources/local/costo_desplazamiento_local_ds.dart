import '../../../services/connection_sqlite_service.dart';
import '../../models/costo_desplazamiento.dart';

abstract class CostoDesplazamientoLocalDataSource {
  Future<List<CostoDesplazamientoModel>> getCostosDesplazamiento();
  Future<int> saveCostoDesplazamiento(
      CostoDesplazamientoModel costoDesplazamiento);
}

class CostoDesplazamientoLocalDataSourceImpl
    implements CostoDesplazamientoLocalDataSource {
  @override
  Future<List<CostoDesplazamientoModel>> getCostosDesplazamiento() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('CostosDesplazamiento_CentroAtencion');
    final result = List<CostoDesplazamientoModel>.from(
        res.map((m) => CostoDesplazamientoModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveCostoDesplazamiento(
      CostoDesplazamientoModel costoDesplazamiento) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'CostosDesplazamiento_CentroAtencion', costoDesplazamiento.toJson());

    return res;
  }
}
