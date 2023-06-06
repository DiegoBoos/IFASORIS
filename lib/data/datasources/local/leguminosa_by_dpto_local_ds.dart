import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/leguminosa_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/leguminosa_model.dart';

abstract class LeguminosaByDptoLocalDataSource {
  Future<List<LeguminosaModel>> getLeguminosasByDpto();
  Future<int> saveLeguminosaByDpto(LeguminosaEntity leguminosa);

  Future<int> saveUbicacionLeguminosas(
      int ubicacionId, List<LstLeguminosa> lstLeguminosas);

  Future<List<LstLeguminosa>> getUbicacionLeguminosas(int? ubicacionId);
}

class LeguminosaByDptoLocalDataSourceImpl
    implements LeguminosaByDptoLocalDataSource {
  @override
  Future<List<LeguminosaModel>> getLeguminosasByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Leguminosas_AspectosSocioEconomicos');
    final result =
        List<LeguminosaModel>.from(res.map((m) => LeguminosaModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveLeguminosaByDpto(LeguminosaEntity leguminosa) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'Leguminosas_AspectosSocioEconomicos', leguminosa.toJson());

    return res;
  }

  @override
  Future<int> saveUbicacionLeguminosas(
      int ubicacionId, List<LstLeguminosa> lstLeguminosas) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp1_UbicacionLeguminosas');

    final ubicacionLeguminosas = lstLeguminosas
        .map((item) => UbicacionLeguminosas(
            leguminosaId: item.leguminosaId, ubicacionId: ubicacionId))
        .toList();

    for (final ubicacionLeguminosa in ubicacionLeguminosas) {
      batch.insert('Asp1_UbicacionLeguminosas', ubicacionLeguminosa.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstLeguminosa>> getUbicacionLeguminosas(int? ubicacionId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp1_UbicacionLeguminosas',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);
    final result =
        List<LstLeguminosa>.from(res.map((m) => LstLeguminosa.fromJson(m)))
            .toList();

    return result;
  }
}
