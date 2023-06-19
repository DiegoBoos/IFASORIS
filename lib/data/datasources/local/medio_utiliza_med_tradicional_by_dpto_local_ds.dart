import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/medio_utiliza_med_tradicional_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/medio_utiliza_med_tradicional_model.dart';

abstract class MedioUtilizaMedTradicionalByDptoLocalDataSource {
  Future<List<MedioUtilizaMedTradicionalModel>>
      getMediosUtilizaMedTradicionalByDpto();
  Future<int> saveMedioUtilizaMedTradicionalByDpto(
      MedioUtilizaMedTradicionalEntity medioUtilizaMedTradicionalByDpto);

  Future<int> saveUbicacionMediosMedTradicional(
      int ubicacionId, List<LstMediosMedTradicional> lstMediosMedTradicional);

  Future<List<LstMediosMedTradicional>> getMediosUtilizaMedTradicional(
      int? ubicacionId);
}

class MedioUtilizaMedTradicionalByDptoLocalDataSourceImpl
    implements MedioUtilizaMedTradicionalByDptoLocalDataSource {
  @override
  Future<List<MedioUtilizaMedTradicionalModel>>
      getMediosUtilizaMedTradicionalByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('MediosUtiliza_AccesoMedTradicional');
    final result = List<MedioUtilizaMedTradicionalModel>.from(
        res.map((m) => MedioUtilizaMedTradicionalModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveMedioUtilizaMedTradicionalByDpto(
      MedioUtilizaMedTradicionalEntity medioUtilizaMedTradicionalByDpto) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('MediosUtiliza_AccesoMedTradicional',
        medioUtilizaMedTradicionalByDpto.toJson());

    return res;
  }

  @override
  Future<int> saveUbicacionMediosMedTradicional(int ubicacionId,
      List<LstMediosMedTradicional> lstMediosMedTradicional) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp1_UbicacionMediosMedTradicional',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);

    final ubicacionMediosMedTradicional = lstMediosMedTradicional
        .map((item) => UbicacionMediosMedTradicional(
            medioUtilizaMedTradicionalId: item.medioUtilizaMedTradId,
            ubicacionId: ubicacionId))
        .toList();

    for (final ubicacionMedioMedTradicional in ubicacionMediosMedTradicional) {
      batch.insert('Asp1_UbicacionMediosMedTradicional',
          ubicacionMedioMedTradicional.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstMediosMedTradicional>> getMediosUtilizaMedTradicional(
      int? ubicacionId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp1_UbicacionMediosMedTradicional',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);
    final result = List<LstMediosMedTradicional>.from(
        res.map((m) => LstMediosMedTradicional.fromJson(m))).toList();

    return result;
  }
}
