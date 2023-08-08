import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/techo_vivienda_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/techo_vivienda_model.dart';

abstract class TechoViviendaLocalDataSource {
  Future<List<TechoViviendaModel>> getTechosVivienda();
  Future<int> saveTechoVivienda(TechoViviendaEntity techoVivienda);

  Future<int> saveTechosVivienda(int datoViviendaId, List<LstTecho> lstTechos);

  Future<List<LstTecho>> getTechosViviendaVivienda(int? datoViviendaId);
}

class TechoViviendaLocalDataSourceImpl implements TechoViviendaLocalDataSource {
  @override
  Future<List<TechoViviendaModel>> getTechosVivienda() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('TechosVivienda_DatosVivienda');
    final result = List<TechoViviendaModel>.from(
        res.map((m) => TechoViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTechoVivienda(TechoViviendaEntity techoVivienda) async {
    final db = await ConnectionSQLiteService.db;

    final res =
        await db.insert('TechosVivienda_DatosVivienda', techoVivienda.toJson());

    return res;
  }

  @override
  Future<int> saveTechosVivienda(
      int datoViviendaId, List<LstTecho> lstTechos) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp2_DatosViviendaTechos',
        where: 'DatoVivienda_id = ?', whereArgs: [datoViviendaId]);

    final viviendaTechos = lstTechos
        .map((item) => ViviendaTechos(
            techoViviendaId: item.techoViviendaId,
            datoViviendaId: datoViviendaId,
            otroTipoTecho: item.otroTipoTecho))
        .toList();

    for (final viviendaTecho in viviendaTechos) {
      batch.insert('Asp2_DatosViviendaTechos', viviendaTecho.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstTecho>> getTechosViviendaVivienda(int? datoViviendaId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp2_DatosViviendaTechos',
        where: 'DatoVivienda_id = ?', whereArgs: [datoViviendaId]);
    final result =
        List<LstTecho>.from(res.map((m) => LstTecho.fromJson(m))).toList();

    return result;
  }
}
