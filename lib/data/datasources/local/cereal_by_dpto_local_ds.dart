import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/cereal_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/cereal_model.dart';

abstract class CerealByDptoLocalDataSource {
  Future<List<CerealModel>> getCerealesByDpto();
  Future<int> saveCerealByDpto(CerealEntity cereal);
  Future<int> saveUbicacionCereales(
      int ubicacionId, List<LstCereal> lstCereales);
  Future<List<LstCereal>> getUbicacionCereales(int? ubicacionId);
}

class CerealByDptoLocalDataSourceImpl implements CerealByDptoLocalDataSource {
  @override
  Future<List<CerealModel>> getCerealesByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Cereales_AspectosSocioEconomicos');
    final result =
        List<CerealModel>.from(res.map((m) => CerealModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveCerealByDpto(CerealEntity cereal) async {
    final db = await ConnectionSQLiteService.db;

    final res =
        await db.insert('Cereales_AspectosSocioEconomicos', cereal.toJson());

    return res;
  }

  @override
  Future<int> saveUbicacionCereales(
      int ubicacionId, List<LstCereal> lstCereales) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp1_UbicacionCereales');

    final ubicacionCereales = lstCereales
        .map((item) => UbicacionCereales(
            cerealId: item.cerealId, ubicacionId: ubicacionId))
        .toList();

    for (final ubicacionCereal in ubicacionCereales) {
      batch.insert('Asp1_UbicacionCereales', ubicacionCereal.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstCereal>> getUbicacionCereales(int? ubicacionId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp1_UbicacionCereales',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);
    final result =
        List<LstCereal>.from(res.map((m) => LstCereal.fromJson(m))).toList();

    return result;
  }
}
