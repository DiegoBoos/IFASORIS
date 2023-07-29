import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/lugar_atencion_medico_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/lugar_atencion_medico_model.dart';

abstract class LugarAtencionMedicoLocalDataSource {
  Future<List<LugarAtencionMedicoModel>> getLugaresAtencionMedico();
  Future<int> saveLugarAtencionMedico(
      LugarAtencionMedicoEntity lugarAtencionMedico);

  Future<List<LstLugarAtencionMedico>> getLugaresAtencionMedicoAtencionSalud(
      int? atencionSaludId);

  Future<int> saveLugaresAtencionMedicoAtencionSalud(
      int atencionSaludId, List<LstLugarAtencionMedico> lstLugarAtencionMedico);
}

class LugarAtencionMedicoLocalDataSourceImpl
    implements LugarAtencionMedicoLocalDataSource {
  @override
  Future<List<LugarAtencionMedicoModel>> getLugaresAtencionMedico() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('LugaresAtencionMedico_AtencionSalud');
    final result = List<LugarAtencionMedicoModel>.from(
        res.map((m) => LugarAtencionMedicoModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveLugarAtencionMedico(
      LugarAtencionMedicoEntity lugarAtencionMedico) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'LugaresAtencionMedico_AtencionSalud', lugarAtencionMedico.toJson());

    return res;
  }

  @override
  Future<List<LstLugarAtencionMedico>> getLugaresAtencionMedicoAtencionSalud(
      int? atencionSaludId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp7_LugaresAtencionAtencionSalud',
        where: 'AtencionSalud_id = ?', whereArgs: [atencionSaludId]);
    final result = List<LstLugarAtencionMedico>.from(
        res.map((m) => LstLugarAtencionMedico.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveLugaresAtencionMedicoAtencionSalud(int atencionSaludId,
      List<LstLugarAtencionMedico> lstLugarAtencionMedico) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp7_LugaresAtencionAtencionSalud',
        where: 'AtencionSalud_id = ?', whereArgs: [atencionSaludId]);

    final lugaresAtencionMedicoAtencionSalud = lstLugarAtencionMedico
        .map((item) => LugarAtencionMedicoAtencionSalud(
            lugarAtencionMedicoId: item.lugarAtencionMedicoId,
            atencionSaludId: atencionSaludId))
        .toList();

    for (final lugarAtencionMedicoAtencionSalud
        in lugaresAtencionMedicoAtencionSalud) {
      batch.insert('Asp7_LugaresAtencionAtencionSalud',
          lugarAtencionMedicoAtencionSalud.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
