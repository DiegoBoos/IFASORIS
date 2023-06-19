import 'package:ifasoris/data/models/nombre_med_tradicional_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/especialidad_med_tradicional_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/especialidad_med_tradicional_model.dart';

abstract class EspecialidadMedTradicionalByDptoLocalDataSource {
  Future<List<EspecialidadMedTradicionalModel>>
      getEspecialidadesMedTradicionalByDpto();
  Future<int> saveEspecialidadMedTradicionalByDpto(
      EspecialidadMedTradicionalEntity especialidadMedTradicionalByDpto);

  Future<int> saveUbicacionEspecialidadMedTradicional(
      int ubicacionId, List<LstEspMedTradicional> lstEspMedTradicional);

  Future<int> saveUbicacionNombresMedTradicional(
      int ubicacionId, List<LstNombreMedTradicional> lstNombreMedTradicional);

  Future<List<LstEspMedTradicional>> getUbicacionEspecialidadesMedTradicional(
      int? ubicacionId);
  Future<List<LstNombreMedTradicional>> getUbicacionNombresMedTradicional(
      int? ubicacionId);
}

class EspecialidadMedTradicionalByDptoLocalDataSourceImpl
    implements EspecialidadMedTradicionalByDptoLocalDataSource {
  @override
  Future<List<EspecialidadMedTradicionalModel>>
      getEspecialidadesMedTradicionalByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('EspecialidadesMedTrad_AccesoMedTradicional');
    final result = List<EspecialidadMedTradicionalModel>.from(
        res.map((m) => EspecialidadMedTradicionalModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveEspecialidadMedTradicionalByDpto(
      EspecialidadMedTradicionalEntity especialidadMedTradicionalByDpto) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('EspecialidadesMedTrad_AccesoMedTradicional',
        especialidadMedTradicionalByDpto.toJson());

    return res;
  }

  @override
  Future<int> saveUbicacionEspecialidadMedTradicional(
      int ubicacionId, List<LstEspMedTradicional> lstEspMedTradicional) async {
    final db = await ConnectionSQLiteService.db;
    Batch batch = db.batch();
    batch.delete('Asp1_UbicacionEspecialidadMedTradicional',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);

    final ubicacionEspecialidadesMedTradicional = lstEspMedTradicional
        .map((item) => UbicacionEspecialidadMedTradicional(
            especialidadMedTradicionalId: item.especialidadMedTradId,
            ubicacionId: ubicacionId))
        .toList();

    for (final ubicacionEspecialidadMedTradicional
        in ubicacionEspecialidadesMedTradicional) {
      batch.insert('Asp1_UbicacionEspecialidadMedTradicional',
          ubicacionEspecialidadMedTradicional.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<int> saveUbicacionNombresMedTradicional(int ubicacionId,
      List<LstNombreMedTradicional> lstNombreMedTradicional) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp1_UbicacionNombresMedTradicional',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);

    final ubicacionNombresMedTradicional = lstNombreMedTradicional
        .map((item) => UbicacionNombresMedTradicional(
            nombreMedTradicional: item.nombreMedTradicional,
            ubicacionId: ubicacionId))
        .toList();

    for (final ubicacionNombreMedTradicional
        in ubicacionNombresMedTradicional) {
      batch.insert('Asp1_UbicacionNombresMedTradicional',
          ubicacionNombreMedTradicional.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstNombreMedTradicional>> getUbicacionNombresMedTradicional(
      int? ubicacionId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp1_UbicacionNombresMedTradicional',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);
    final result = List<LstNombreMedTradicional>.from(
        res.map((m) => LstNombreMedTradicional.fromJson(m))).toList();

    return result;
  }

  @override
  Future<List<LstEspMedTradicional>> getUbicacionEspecialidadesMedTradicional(
      int? ubicacionId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp1_UbicacionEspecialidadMedTradicional',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);
    final result = List<LstEspMedTradicional>.from(
        res.map((m) => LstEspMedTradicional.fromJson(m))).toList();

    return result;
  }
}
