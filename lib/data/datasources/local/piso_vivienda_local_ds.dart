import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/piso_vivienda_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/piso_vivienda_model.dart';

abstract class PisoViviendaLocalDataSource {
  Future<List<PisoViviendaModel>> getPisosVivienda();
  Future<int> savePisoVivienda(PisoViviendaEntity pisoVivienda);
  Future<int> savePisosVivienda(int datoViviendaId, List<LstPiso> lstPiso);
  Future<List<LstPiso>> getPisosViviendaVivienda(int? datoViviendaId);
}

class PisoViviendaLocalDataSourceImpl implements PisoViviendaLocalDataSource {
  @override
  Future<List<PisoViviendaModel>> getPisosVivienda() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('PisosVivienda_DatosVivienda');
    final result = List<PisoViviendaModel>.from(
        res.map((m) => PisoViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> savePisoVivienda(PisoViviendaEntity pisoVivienda) async {
    final db = await ConnectionSQLiteService.db;

    final res =
        await db.insert('PisosVivienda_DatosVivienda', pisoVivienda.toJson());

    return res;
  }

  @override
  Future<List<LstPiso>> getPisosViviendaVivienda(int? datoViviendaId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp2_DatosViviendaPisos',
        where: 'DatoVivienda_id = ?', whereArgs: [datoViviendaId]);
    final result =
        List<LstPiso>.from(res.map((m) => LstPiso.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> savePisosVivienda(
      int datoViviendaId, List<LstPiso> lstPiso) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp2_DatosViviendaPisos',
        where: 'DatoVivienda_id = ?', whereArgs: [datoViviendaId]);

    final viviendaPisos = lstPiso
        .map((item) => ViviendaPisos(
            pisoViviendaId: item.pisoViviendaId,
            datoViviendaId: datoViviendaId,
            otroTipoPiso: item.otroTipoPiso))
        .toList();

    for (final viviendaPiso in viviendaPisos) {
      batch.insert('Asp2_DatosViviendaPisos', viviendaPiso.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
