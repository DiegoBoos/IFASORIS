import 'package:sqflite/sqflite.dart';

import '../../../services/connection_sqlite_service.dart';
import '../../models/factor_riesgo_vivienda.dart';

abstract class FactorRiesgoViviendaLocalDataSource {
  Future<List<FactorRiesgoViviendaModel>> getFactoresRiesgo();
  Future<int> saveFactorRiesgoVivienda(
      FactorRiesgoViviendaModel factorRiesgoVivienda);

  Future<int> saveFactoresRiesgoVivienda(
      int datoViviendaId, List<LstFactorRiesgo> lstFactorRiesgo);

  Future<List<LstFactorRiesgo>> getFactoresRiesgoVivienda(int? datoViviendaId);
}

class FactorRiesgoViviendaLocalDataSourceImpl
    implements FactorRiesgoViviendaLocalDataSource {
  @override
  Future<List<FactorRiesgoViviendaModel>> getFactoresRiesgo() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('FactoresRiesgoVivienda_DatosVivienda');
    final result = List<FactorRiesgoViviendaModel>.from(
        res.map((m) => FactorRiesgoViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveFactorRiesgoVivienda(
      FactorRiesgoViviendaModel factorRiesgoVivienda) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'FactoresRiesgoVivienda_DatosVivienda', factorRiesgoVivienda.toJson());

    return res;
  }

  @override
  Future<int> saveFactoresRiesgoVivienda(
      int datoViviendaId, List<LstFactorRiesgo> lstFactorRiesgo) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp2_DatosViviendaFactoresRiesgo',
        where: 'DatoVivienda_id = ?', whereArgs: [datoViviendaId]);

    final factoresRiesgoVivienda = lstFactorRiesgo
        .map((item) => ViviendaFactoresRiesgo(
            factorRiesgoViviendaId: item.factorRiesgoViviendaId,
            datoViviendaId: datoViviendaId,
            otroFactorRiesgo: item.otroFactorRiesgo))
        .toList();

    for (final factorRiesgoVivienda in factoresRiesgoVivienda) {
      batch.insert(
          'Asp2_DatosViviendaFactoresRiesgo', factorRiesgoVivienda.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstFactorRiesgo>> getFactoresRiesgoVivienda(
      int? datoViviendaId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp2_DatosViviendaFactoresRiesgo',
        where: 'DatoVivienda_id = ?', whereArgs: [datoViviendaId]);
    final result =
        List<LstFactorRiesgo>.from(res.map((m) => LstFactorRiesgo.fromJson(m)))
            .toList();

    return result;
  }
}
