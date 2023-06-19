import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/tipo_combustible_vivienda_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/tipo_combustible_vivienda_model.dart';

abstract class TipoCombustibleViviendaByDptoLocalDataSource {
  Future<List<TipoCombustibleViviendaModel>>
      getTiposCombustibleViviendaByDpto();
  Future<int> saveTipoCombustibleViviendaByDpto(
      TipoCombustibleViviendaEntity tipoCombustibleViviendaByDpto);

  Future<int> saveTiposCombustibleVivienda(
      int datoViviendaId, List<LstTiposCombustible> lstTiposCombustible);

  Future<List<LstTiposCombustible>> getTiposCombustibleVivienda(
      int? datoViviendaId);
}

class TipoCombustibleViviendaByDptoLocalDataSourceImpl
    implements TipoCombustibleViviendaByDptoLocalDataSource {
  @override
  Future<List<TipoCombustibleViviendaModel>>
      getTiposCombustibleViviendaByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('TiposCombustibleVivienda_DatosVivienda');
    final result = List<TipoCombustibleViviendaModel>.from(
        res.map((m) => TipoCombustibleViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTipoCombustibleViviendaByDpto(
      TipoCombustibleViviendaEntity tipoCombustibleViviendaByDpto) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('TiposCombustibleVivienda_DatosVivienda',
        tipoCombustibleViviendaByDpto.toJson());

    return res;
  }

  @override
  Future<int> saveTiposCombustibleVivienda(
      int datoViviendaId, List<LstTiposCombustible> lstTiposCombustible) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp2_DatosViviendaTiposCombustible',
        where: 'DatoVivienda_id = ?', whereArgs: [datoViviendaId]);

    final viviendaTiposCombustible = lstTiposCombustible
        .map((item) => ViviendaTiposCombustible(
            tipoCombustibleViviendaId: item.tipoCombustibleViviendaId,
            datoViviendaId: datoViviendaId,
            otroTipoCombustible: item.otroTipoCombustible))
        .toList();

    for (final viviendaTipoCombustible in viviendaTiposCombustible) {
      batch.insert('Asp2_DatosViviendaTiposCombustible',
          viviendaTipoCombustible.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstTiposCombustible>> getTiposCombustibleVivienda(
      int? datoViviendaId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp2_DatosViviendaTiposCombustible',
        where: 'DatoVivienda_id', whereArgs: [datoViviendaId]);
    final result = List<LstTiposCombustible>.from(
        res.map((m) => LstTiposCombustible.fromJson(m))).toList();

    return result;
  }
}
