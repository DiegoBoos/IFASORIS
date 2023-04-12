import '../../../domain/entities/costo_desplazamiento_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/costo_desplazamiento_model.dart';

abstract class CostoDesplazamientoLocalDataSource {
  Future<List<CostoDesplazamientoModel>> getCostosDesplazamiento();
  Future<int> saveCostoDesplazamiento(
      CostoDesplazamientoEntity costoDesplazamiento);
}

class CostoDesplazamientoLocalDataSourceImpl
    implements CostoDesplazamientoLocalDataSource {
  @override
  Future<List<CostoDesplazamientoModel>> getCostosDesplazamiento() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('CostoDesplazamiento');
    final result = List<CostoDesplazamientoModel>.from(
        res.map((m) => CostoDesplazamientoModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveCostoDesplazamiento(
      CostoDesplazamientoEntity costoDesplazamiento) async {
    final db = await ConnectionSQLiteService.db;

    final res =
        await db.insert('CostoDesplazamiento', costoDesplazamiento.toJson());

    return res;
  }
}
