import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/dificultad_acceso_med_tradicional_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/dificultad_acceso_med_tradicional_model.dart';

abstract class DificultadAccesoMedTradicionalByDptoLocalDataSource {
  Future<List<DificultadAccesoMedTradicionalModel>>
      getDificultadesAccesoMedTradicionalByDpto();
  Future<int> saveDificultadAccesoMedTradicionalByDpto(
      DificultadAccesoMedTradicionalEntity
          dificultadAccesoMedTradicionalByDpto);

  Future<int> saveUbicacionAccesoMedTradicional(
      int ubicacionId,
      List<LstDificultadAccesoMedTradicional>
          lstDificultadAccesoMedTradicional);

  Future<List<LstDificultadAccesoMedTradicional>>
      getUbicacionDificultadesAccesoMedTradicional(int? ubicacionId);
}

class DificultadAccesoMedTradicionalByDptoLocalDataSourceImpl
    implements DificultadAccesoMedTradicionalByDptoLocalDataSource {
  @override
  Future<List<DificultadAccesoMedTradicionalModel>>
      getDificultadesAccesoMedTradicionalByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('DificultadesAcceso_AccesoMedTradicional');
    final result = List<DificultadAccesoMedTradicionalModel>.from(
            res.map((m) => DificultadAccesoMedTradicionalModel.fromJson(m)))
        .toList();

    return result;
  }

  @override
  Future<int> saveDificultadAccesoMedTradicionalByDpto(
      DificultadAccesoMedTradicionalEntity
          dificultadAccesoMedTradicionalByDpto) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('DificultadesAcceso_AccesoMedTradicional',
        dificultadAccesoMedTradicionalByDpto.toJson());

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
