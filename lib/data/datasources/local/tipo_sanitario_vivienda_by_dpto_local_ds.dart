import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/tipo_sanitario_vivienda_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/tipo_sanitario_vivienda_model.dart';

abstract class TipoSanitarioViviendaByDptoLocalDataSource {
  Future<List<TipoSanitarioViviendaModel>> getTiposSanitarioViviendaByDpto();
  Future<int> saveTipoSanitarioViviendaByDpto(
      TipoSanitarioViviendaEntity tipoSanitarioViviendaByDpto);

  Future<int> saveTiposSanitarioVivienda(
      int datoViviendaId, List<LstTiposSanitario> lstTiposSanitario);

  Future<List<LstTiposSanitario>> getTiposSanitarioVivienda(
      int? datoViviendaId);
}

class TipoSanitarioViviendaByDptoLocalDataSourceImpl
    implements TipoSanitarioViviendaByDptoLocalDataSource {
  @override
  Future<List<TipoSanitarioViviendaModel>>
      getTiposSanitarioViviendaByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('TiposSanitarioVivienda_DatosVivienda');
    final result = List<TipoSanitarioViviendaModel>.from(
        res.map((m) => TipoSanitarioViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTipoSanitarioViviendaByDpto(
      TipoSanitarioViviendaEntity tipoSanitarioViviendaByDpto) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('TiposSanitarioVivienda_DatosVivienda',
        tipoSanitarioViviendaByDpto.toJson());

    return res;
  }

  @override
  Future<int> saveTiposSanitarioVivienda(
      int datoViviendaId, List<LstTiposSanitario> lstTiposSanitario) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp2_DatosViviendaTiposSanitario');

    final viviendaTiposSanitario = lstTiposSanitario
        .map((item) => ViviendaTiposSanitario(
            tipoSanitarioViviendaId: item.tipoSanitarioViviendaId,
            datoViviendaId: datoViviendaId,
            otroTipoSanitario: item.otroTipoSanitario))
        .toList();

    for (final viviendaTipoSanitario in viviendaTiposSanitario) {
      batch.insert(
          'Asp2_DatosViviendaTiposSanitario', viviendaTipoSanitario.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstTiposSanitario>> getTiposSanitarioVivienda(
      int? datoViviendaId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp2_DatosViviendaTiposSanitario',
        where: 'DatoVivienda_id', whereArgs: [datoViviendaId]);
    final result = List<LstTiposSanitario>.from(
        res.map((m) => LstTiposSanitario.fromJson(m))).toList();

    return result;
  }
}
