import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/factor_riesgo_vivienda_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/factor_riesgo_vivienda_model.dart';

abstract class FactorRiesgoViviendaByDptoLocalDataSource {
  Future<List<FactorRiesgoViviendaModel>> getFactoresRiesgoViviendaByDpto();
  Future<int> saveFactorRiesgoViviendaByDpto(
      FactorRiesgoViviendaEntity factorRiesgoViviendaByDpto);

  Future<int> saveFactoresRiesgoVivienda(
      int datoViviendaId, List<LstFactoresRiesgo> lstFactoresRiesgo);

  Future<List<LstFactoresRiesgo>> getFactoresRiesgoVivienda(
      int? datoViviendaId);
}

class FactorRiesgoViviendaByDptoLocalDataSourceImpl
    implements FactorRiesgoViviendaByDptoLocalDataSource {
  @override
  Future<List<FactorRiesgoViviendaModel>>
      getFactoresRiesgoViviendaByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('FactoresRiesgoVivienda_DatosVivienda');
    final result = List<FactorRiesgoViviendaModel>.from(
        res.map((m) => FactorRiesgoViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveFactorRiesgoViviendaByDpto(
      FactorRiesgoViviendaEntity factorRiesgoViviendaByDpto) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('FactoresRiesgoVivienda_DatosVivienda',
        factorRiesgoViviendaByDpto.toJson());

    return res;
  }

  @override
  Future<int> saveFactoresRiesgoVivienda(
      int datoViviendaId, List<LstFactoresRiesgo> lstFactoresRiesgo) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp2_DatosViviendaFactoresRiesgo',
        where: 'DatoVivienda_id = ?', whereArgs: [datoViviendaId]);

    final factoresRiesgoVivienda = lstFactoresRiesgo
        .map((item) => ViviendaFactoresRiesgo(
              factorRiesgoViviendaId: item.factorRiesgoViviendaId,
              datoViviendaId: datoViviendaId,
            ))
        .toList();

    for (final factorRiesgoVivienda in factoresRiesgoVivienda) {
      batch.insert(
          'Asp2_DatosViviendaFactoresRiesgo', factorRiesgoVivienda.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstFactoresRiesgo>> getFactoresRiesgoVivienda(
      int? datoViviendaId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp2_DatosViviendaFactoresRiesgo',
        where: 'DatoVivienda_id', whereArgs: [datoViviendaId]);
    final result = List<LstFactoresRiesgo>.from(
        res.map((m) => LstFactoresRiesgo.fromJson(m))).toList();

    return result;
  }
}
