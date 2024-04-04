import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/tuberculo_platano_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/tuberculo_platano_model.dart';

abstract class TuberculoPlatanoLocalDataSource {
  Future<List<TuberculoPlatanoModel>> getTuberculosPlatanos();
  Future<int> saveTuberculoPlatano(TuberculoPlatanoEntity tuberculoPlatano);

  Future<int> saveUbicacionTuberculosPlatanos(
      int ubicacionId, List<LstTuberculo> lstTuberculos);

  Future<List<LstTuberculo>> getUbicacionTuberculosPlatanos(int? ubicacionId);
}

class TuberculoPlatanoLocalDataSourceImpl
    implements TuberculoPlatanoLocalDataSource {
  @override
  Future<List<TuberculoPlatanoModel>> getTuberculosPlatanos() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('TuberculosPlatanos_AspectosSocioEconomicos');
    final result = List<TuberculoPlatanoModel>.from(
        res.map((m) => TuberculoPlatanoModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTuberculoPlatano(
      TuberculoPlatanoEntity tuberculoPlatano) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('TuberculosPlatanos_AspectosSocioEconomicos',
        tuberculoPlatano.toJson());

    return res;
  }

  @override
  Future<int> saveUbicacionTuberculosPlatanos(
      int ubicacionId, List<LstTuberculo> lstTuberculos) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp1_UbicacionTuberculosPlatanos',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);

    final ubicacionTuberculosPlatanos = lstTuberculos
        .map((item) => UbicacionTuberculosPlatanos(
            tuberculoPlatanoId: item.tuberculoPlatanoId,
            ubicacionId: ubicacionId,
            otroTuberculoPlatano: item.otroTuberculoPlatano))
        .toList();

    for (final ubicacionTuberculoPlatano in ubicacionTuberculosPlatanos) {
      batch.insert('Asp1_UbicacionTuberculosPlatanos',
          ubicacionTuberculoPlatano.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstTuberculo>> getUbicacionTuberculosPlatanos(
      int? ubicacionId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp1_UbicacionTuberculosPlatanos',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);
    final result =
        List<LstTuberculo>.from(res.map((m) => LstTuberculo.fromJson(m)))
            .toList();

    return result;
  }
}
