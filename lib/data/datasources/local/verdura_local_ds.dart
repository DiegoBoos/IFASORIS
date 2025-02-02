import 'package:sqflite/sqflite.dart';

import '../../../services/connection_sqlite_service.dart';
import '../../models/verdura.dart';

abstract class VerduraLocalDataSource {
  Future<List<VerduraModel>> getVerduras();
  Future<int> saveVerdura(VerduraModel verdura);

  Future<int> saveUbicacionVerduras(
      int ubicacionId, List<LstVerdura> lstVerduras);

  Future<List<LstVerdura>> getUbicacionVerduras(int? ubicacionId);
}

class VerduraLocalDataSourceImpl implements VerduraLocalDataSource {
  @override
  Future<List<VerduraModel>> getVerduras() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Verduras_AspectosSocioEconomicos');
    final result =
        List<VerduraModel>.from(res.map((m) => VerduraModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveVerdura(VerduraModel verdura) async {
    final db = await ConnectionSQLiteService.db;

    final res =
        await db.insert('Verduras_AspectosSocioEconomicos', verdura.toJson());

    return res;
  }

  @override
  Future<int> saveUbicacionVerduras(
      int ubicacionId, List<LstVerdura> lstVerduras) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp1_UbicacionVerduras',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);

    final ubicacionVerduras = lstVerduras
        .map((item) => UbicacionVerduras(
            verduraId: item.verduraId,
            ubicacionId: ubicacionId,
            otroVerdura: item.otroVerdura))
        .toList();

    for (final ubicacionVerdura in ubicacionVerduras) {
      batch.insert('Asp1_UbicacionVerduras', ubicacionVerdura.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstVerdura>> getUbicacionVerduras(int? ubicacionId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp1_UbicacionVerduras',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);
    final result =
        List<LstVerdura>.from(res.map((m) => LstVerdura.fromJson(m))).toList();

    return result;
  }
}
