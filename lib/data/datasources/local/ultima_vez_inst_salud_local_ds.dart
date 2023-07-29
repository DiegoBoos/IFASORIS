import '../../../domain/entities/ultima_vez_inst_salud_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/ultima_vez_inst_salud_model.dart';

abstract class UltimaVezInstSaludLocalDataSource {
  Future<List<UltimaVezInstSaludModel>> getUltimasVecesInstSalud();
  Future<int> saveUltimaVezInstSalud(
      UltimaVezInstSaludEntity ultimaVezInstSalud);
}

class UltimaVezInstSaludLocalDataSourceImpl
    implements UltimaVezInstSaludLocalDataSource {
  @override
  Future<List<UltimaVezInstSaludModel>> getUltimasVecesInstSalud() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('UltimaVezInstSalud_CuidadoSaludCondRiesgo');
    final result = List<UltimaVezInstSaludModel>.from(
        res.map((m) => UltimaVezInstSaludModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveUltimaVezInstSalud(
      UltimaVezInstSaludEntity ultimaVezInstSalud) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('UltimaVezInstSalud_CuidadoSaludCondRiesgo',
        ultimaVezInstSalud.toJson());

    return res;
  }
}
