import 'package:sqflite/sqflite.dart';

import '../../../services/connection_sqlite_service.dart';
import '../../models/dificultad_acceso_ca.dart';

abstract class DificultadAccesoCALocalDataSource {
  Future<List<DificultadAccesoCAModel>> getDificultadesAccesoCA();
  Future<int> saveDificultadAccesoCA(
      DificultadAccesoCAModel dificultadAccesoCA);

  Future<int> saveUbicacionDificultadesAcceso(int ubicacionId,
      List<LstDificultadAccesoAtencion> lstDificultadAccesoAtencion);

  Future<List<LstDificultadAccesoAtencion>> getUbicacionDificultadesAcceso(
      int? ubicacionId);
}

class DificultadAccesoCALocalDataSourceImpl
    implements DificultadAccesoCALocalDataSource {
  @override
  Future<List<DificultadAccesoCAModel>> getDificultadesAccesoCA() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('DificultadesAcceso_CentroAtencion');
    final result = List<DificultadAccesoCAModel>.from(
        res.map((m) => DificultadAccesoCAModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveDificultadAccesoCA(
      DificultadAccesoCAModel dificultadAccesoCA) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'DificultadesAcceso_CentroAtencion', dificultadAccesoCA.toJson());

    return res;
  }

  @override
  Future<int> saveUbicacionDificultadesAcceso(int ubicacionId,
      List<LstDificultadAccesoAtencion> lstDificultadAccesoAtencion) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp1_UbicacionDificultadAcceso',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);

    final ubicacionDificultadesAcceso = lstDificultadAccesoAtencion
        .map((item) => UbicacionDificultadAcceso(
            dificultadAccesoId: item.dificultaAccesoId,
            ubicacionId: ubicacionId))
        .toList();

    for (final ubicacionDificultadAcceso in ubicacionDificultadesAcceso) {
      batch.insert(
          'Asp1_UbicacionDificultadAcceso', ubicacionDificultadAcceso.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstDificultadAccesoAtencion>> getUbicacionDificultadesAcceso(
      int? ubicacionId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp1_UbicacionDificultadAcceso',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);
    final result = List<LstDificultadAccesoAtencion>.from(
        res.map((m) => LstDificultadAccesoAtencion.fromJson(m))).toList();

    return result;
  }
}
