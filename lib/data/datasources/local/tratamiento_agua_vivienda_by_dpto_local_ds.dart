import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/tratamiento_agua_vivienda_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/tratamiento_agua_vivienda_model.dart';

abstract class TratamientoAguaViviendaByDptoLocalDataSource {
  Future<List<TratamientoAguaViviendaModel>>
      getTratamientosAguaViviendaByDpto();
  Future<int> saveTratamientoAguaViviendaByDpto(
      TratamientoAguaViviendaEntity tratamientoAguaViviendaByDpto);

  Future<int> saveTmtoAguasVivienda(
      int datoViviendaId, List<LstTmtoAgua> lstTmtoAguas);

  Future<List<LstTmtoAgua>> getTratamientosAguaVivienda(int? datoViviendaId);
}

class TratamientoAguaViviendaByDptoLocalDataSourceImpl
    implements TratamientoAguaViviendaByDptoLocalDataSource {
  @override
  Future<List<TratamientoAguaViviendaModel>>
      getTratamientosAguaViviendaByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('TratamientoAguaVivienda_DatosVivienda');
    final result = List<TratamientoAguaViviendaModel>.from(
        res.map((m) => TratamientoAguaViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTratamientoAguaViviendaByDpto(
      TratamientoAguaViviendaEntity tratamientoAguaViviendaByDpto) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('TratamientoAguaVivienda_DatosVivienda',
        tratamientoAguaViviendaByDpto.toJson());

    return res;
  }

  @override
  Future<int> saveTmtoAguasVivienda(
      int datoViviendaId, List<LstTmtoAgua> lstTmtoAguas) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp2_DatosViviendaTratamientosAgua');

    final viviendaTratamientosAgua = lstTmtoAguas
        .map((item) => ViviendaTratamientosAgua(
            tratamientoAguaViviendaId: item.tratamientoAguaViviendaId,
            datoViviendaId: datoViviendaId))
        .toList();

    for (final viviendaTratamientoAgua in viviendaTratamientosAgua) {
      batch.insert('Asp2_DatosViviendaTratamientosAgua',
          viviendaTratamientoAgua.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstTmtoAgua>> getTratamientosAguaVivienda(
      int? datoViviendaId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp2_DatosViviendaTratamientosAgua',
        where: 'DatoVivienda_id = ?', whereArgs: [datoViviendaId]);
    final result =
        List<LstTmtoAgua>.from(res.map((m) => LstTmtoAgua.fromJson(m)))
            .toList();

    return result;
  }
}
