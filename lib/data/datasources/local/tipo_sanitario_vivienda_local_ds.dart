import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/tipo_sanitario_vivienda_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/tipo_sanitario_vivienda_model.dart';

abstract class TipoSanitarioViviendaLocalDataSource {
  Future<List<TipoSanitarioViviendaModel>> getTiposSanitario();
  Future<int> saveTipoSanitarioVivienda(
      TipoSanitarioViviendaEntity tipoSanitarioVivienda);

  Future<int> saveTiposSanitarioVivienda(
      int datoViviendaId, List<LstTipoSanitario> lstTipoSanitario);

  Future<List<LstTipoSanitario>> getTiposSanitarioVivienda(int? datoViviendaId);
}

class TipoSanitarioViviendaLocalDataSourceImpl
    implements TipoSanitarioViviendaLocalDataSource {
  @override
  Future<List<TipoSanitarioViviendaModel>> getTiposSanitario() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('TiposSanitarioVivienda_DatosVivienda');
    final result = List<TipoSanitarioViviendaModel>.from(
        res.map((m) => TipoSanitarioViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTipoSanitarioVivienda(
      TipoSanitarioViviendaEntity tipoSanitarioVivienda) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'TiposSanitarioVivienda_DatosVivienda', tipoSanitarioVivienda.toJson());

    return res;
  }

  @override
  Future<int> saveTiposSanitarioVivienda(
      int datoViviendaId, List<LstTipoSanitario> lstTipoSanitario) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp2_DatosViviendaTiposSanitario',
        where: 'DatoVivienda_id = ?', whereArgs: [datoViviendaId]);

    final viviendaTiposSanitario = lstTipoSanitario
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
  Future<List<LstTipoSanitario>> getTiposSanitarioVivienda(
      int? datoViviendaId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp2_DatosViviendaTiposSanitario',
        where: 'DatoVivienda_id = ?', whereArgs: [datoViviendaId]);
    final result = List<LstTipoSanitario>.from(
        res.map((m) => LstTipoSanitario.fromJson(m))).toList();

    return result;
  }
}
