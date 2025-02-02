import 'package:sqflite/sqflite.dart';

import '../../../services/connection_sqlite_service.dart';
import '../../models/dificultad_acceso_med_tradicional.dart';

abstract class DificultadAccesoMedTradicionalLocalDataSource {
  Future<List<DificultadAccesoMedTradicionalModel>>
      getDificultadesAccesoMedTradicional();
  Future<int> saveDificultadAccesoMedTradicional(
      DificultadAccesoMedTradicionalModel dificultadAccesoMedTradicional);

  Future<int> saveUbicacionAccesoMedTradicional(
      int ubicacionId,
      List<LstDificultadAccesoMedTradicional>
          lstDificultadAccesoMedTradicional);

  Future<List<LstDificultadAccesoMedTradicional>>
      getUbicacionDificultadesAccesoMedTradicional(int? ubicacionId);
}

class DificultadAccesoMedTradicionalLocalDataSourceImpl
    implements DificultadAccesoMedTradicionalLocalDataSource {
  @override
  Future<List<DificultadAccesoMedTradicionalModel>>
      getDificultadesAccesoMedTradicional() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('DificultadesAcceso_AccesoMedTradicional');
    final result = List<DificultadAccesoMedTradicionalModel>.from(
            res.map((m) => DificultadAccesoMedTradicionalModel.fromJson(m)))
        .toList();

    return result;
  }

  @override
  Future<int> saveDificultadAccesoMedTradicional(
      DificultadAccesoMedTradicionalModel
          dificultadAccesoMedTradicional) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('DificultadesAcceso_AccesoMedTradicional',
        dificultadAccesoMedTradicional.toJson());

    return res;
  }

  @override
  Future<int> saveUbicacionAccesoMedTradicional(
      int ubicacionId,
      List<LstDificultadAccesoMedTradicional>
          lstDificultadAccesoMedTradicional) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp1_UbicacionAccesoMedTradicional',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);

    final ubicacionDificultadesAccesoMedTradicional =
        lstDificultadAccesoMedTradicional
            .map((item) => UbicacionDificultadAccesoMedTradicional(
                dificultadAccesoMedTradId: item.dificultadAccesoMedTradId,
                ubicacionId: ubicacionId))
            .toList();

    for (final ubicacionDificultadAccesoMedTradicional
        in ubicacionDificultadesAccesoMedTradicional) {
      batch.insert('Asp1_UbicacionAccesoMedTradicional',
          ubicacionDificultadAccesoMedTradicional.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstDificultadAccesoMedTradicional>>
      getUbicacionDificultadesAccesoMedTradicional(int? ubicacionId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp1_UbicacionAccesoMedTradicional',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);
    final result = List<LstDificultadAccesoMedTradicional>.from(
        res.map((m) => LstDificultadAccesoMedTradicional.fromJson(m))).toList();

    return result;
  }
}
