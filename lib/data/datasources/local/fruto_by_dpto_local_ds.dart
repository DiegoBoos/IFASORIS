import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/fruto_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/fruto_model.dart';

abstract class FrutoByDptoLocalDataSource {
  Future<List<FrutoModel>> getFrutosByDpto();
  Future<int> saveFrutoByDpto(FrutoEntity fruto);
  Future<int> saveUbicacionFrutos(int ubicacionId, List<LstFruto> lstFrutos);
  Future<List<LstFruto>> getUbicacionFrutos(int? ubicacionId);
}

class FrutoByDptoLocalDataSourceImpl implements FrutoByDptoLocalDataSource {
  @override
  Future<List<FrutoModel>> getFrutosByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Frutos_AspectosSocioEconomicos');
    final result =
        List<FrutoModel>.from(res.map((m) => FrutoModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveFrutoByDpto(FrutoEntity fruto) async {
    final db = await ConnectionSQLiteService.db;

    final res =
        await db.insert('Frutos_AspectosSocioEconomicos', fruto.toJson());

    return res;
  }

  @override
  Future<int> saveUbicacionFrutos(
      int ubicacionId, List<LstFruto> lstFrutos) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp1_UbicacionFrutos',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);

    final ubicacionFrutos = lstFrutos
        .map((item) =>
            UbicacionFrutos(frutoId: item.frutoId, ubicacionId: ubicacionId))
        .toList();

    for (final ubicacionFruto in ubicacionFrutos) {
      batch.insert('Asp1_UbicacionFrutos', ubicacionFruto.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstFruto>> getUbicacionFrutos(int? ubicacionId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp1_UbicacionFrutos',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);
    final result =
        List<LstFruto>.from(res.map((m) => LstFruto.fromJson(m))).toList();

    return result;
  }
}
