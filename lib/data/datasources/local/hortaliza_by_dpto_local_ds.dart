import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/hortaliza_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/hortaliza_model.dart';

abstract class HortalizaByDptoLocalDataSource {
  Future<List<HortalizaModel>> getHortalizasByDpto();
  Future<int> saveHortalizaByDpto(HortalizaEntity hortaliza);

  Future<int> saveUbicacionHortalizas(
      int ubicacionId, List<LstHortaliza> lstHortalizas);

  Future<List<LstHortaliza>> getUbicacionHortalizas(int? ubicacionId);
}

class HortalizaByDptoLocalDataSourceImpl
    implements HortalizaByDptoLocalDataSource {
  @override
  Future<List<HortalizaModel>> getHortalizasByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Hortalizas_AspectosSocioEconomicos');
    final result =
        List<HortalizaModel>.from(res.map((m) => HortalizaModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveHortalizaByDpto(HortalizaEntity hortaliza) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'Hortalizas_AspectosSocioEconomicos', hortaliza.toJson());

    return res;
  }

  @override
  Future<int> saveUbicacionHortalizas(
      int ubicacionId, List<LstHortaliza> lstHortalizas) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp1_UbicacionHortalizas',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);

    final ubicacionHortalizas = lstHortalizas
        .map((item) => UbicacionHortalizas(
            hortalizaId: item.hortalizaId, ubicacionId: ubicacionId))
        .toList();

    for (final ubicacionHortaliza in ubicacionHortalizas) {
      batch.insert('Asp1_UbicacionHortalizas', ubicacionHortaliza.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstHortaliza>> getUbicacionHortalizas(int? ubicacionId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp1_UbicacionHortalizas',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);
    final result =
        List<LstHortaliza>.from(res.map((m) => LstHortaliza.fromJson(m)))
            .toList();

    return result;
  }
}
