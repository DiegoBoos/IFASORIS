import 'package:sqflite/sqflite.dart';

import '../../../services/connection_sqlite_service.dart';
import '../../models/medio_utiliza_ca.dart';

abstract class MedioUtilizaCALocalDataSource {
  Future<List<MedioUtilizaCAModel>> getMediosUtilizaCA();
  Future<int> saveMedioUtilizaCA(MedioUtilizaCAModel medioUtilizaCA);
  Future<int> saveUbicacionMediosUtilizaCA(
      int ubicacionId, List<LstMediosUtilizaCA> lstMediosUtilizaCA);
  Future<List<LstMediosUtilizaCA>> getUbicacionMediosUtilizaCA(
      int? ubicacionId);
}

class MedioUtilizaCALocalDataSourceImpl
    implements MedioUtilizaCALocalDataSource {
  @override
  Future<List<MedioUtilizaCAModel>> getMediosUtilizaCA() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('MediosUtiliza_CentroAtencion');
    final mediosUtilizaCADB = List<MedioUtilizaCAModel>.from(
        res.map((m) => MedioUtilizaCAModel.fromJson(m))).toList();

    return mediosUtilizaCADB;
  }

  @override
  Future<int> saveMedioUtilizaCA(MedioUtilizaCAModel medioUtilizaCA) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'MediosUtiliza_CentroAtencion', medioUtilizaCA.toJson());

    return res;
  }

  @override
  Future<List<LstMediosUtilizaCA>> getUbicacionMediosUtilizaCA(
      int? ubicacionId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp1_UbicacionMediosCentroAtencion',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);
    final result = List<LstMediosUtilizaCA>.from(
        res.map((m) => LstMediosUtilizaCA.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveUbicacionMediosUtilizaCA(
      int ubicacionId, List<LstMediosUtilizaCA> lstMediosUtilizaCA) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp1_UbicacionMediosCentroAtencion',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);

    final ubicacionMediosUtilizaCA = lstMediosUtilizaCA
        .map((item) => UbicacionMediosUtilizaCA(
              ubicacionId: ubicacionId,
              medioUtilizaId: item.medioUtilizaId,
            ))
        .toList();

    for (final ubicacionMedioUtilizaCA in ubicacionMediosUtilizaCA) {
      batch.insert('Asp1_UbicacionMediosCentroAtencion',
          ubicacionMedioUtilizaCA.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
