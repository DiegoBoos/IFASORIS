import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/servicio_publico_vivienda_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/servicio_publico_vivienda_model.dart';

abstract class ServicioPublicoViviendaByDptoLocalDataSource {
  Future<List<ServicioPublicoViviendaModel>>
      getServiciosPublicosViviendaByDpto();
  Future<int> saveServicioPublicoViviendaByDpto(
      ServicioPublicoViviendaEntity servicioPublicoVivienda);

  Future<int> saveServiciosPublicosVivienda(
      int datoViviendaId, List<LstServPublico> lstServPublicos);

  Future<List<LstServPublico>> getServiciosPublicosVivienda(
      int? datoViviendaId);
}

class ServicioPublicoViviendaByDptoLocalDataSourceImpl
    implements ServicioPublicoViviendaByDptoLocalDataSource {
  @override
  Future<List<ServicioPublicoViviendaModel>>
      getServiciosPublicosViviendaByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('ServiciosPublicosVivienda_DatosVivienda');
    final result = List<ServicioPublicoViviendaModel>.from(
        res.map((m) => ServicioPublicoViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveServicioPublicoViviendaByDpto(
      ServicioPublicoViviendaEntity servicioPublicoVivienda) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('ServiciosPublicosVivienda_DatosVivienda',
        servicioPublicoVivienda.toJson());

    return res;
  }

  @override
  Future<int> saveServiciosPublicosVivienda(
      int datoViviendaId, List<LstServPublico> lstServPublicos) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp2_DatosViviendaServiciosPublicos');

    final viviendaServiciosPublicos = lstServPublicos
        .map((item) => ViviendaServiciosPublicos(
            servicioPublicoViviendaId: item.servicioPublicoViviendaId,
            datoViviendaId: datoViviendaId))
        .toList();

    for (final viviendaServicioPublico in viviendaServiciosPublicos) {
      batch.insert('Asp2_DatosViviendaServiciosPublicos',
          viviendaServicioPublico.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstServPublico>> getServiciosPublicosVivienda(
      int? datoViviendaId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp2_DatosViviendaServiciosPublicos',
        where: 'DatoVivienda_id = ?', whereArgs: [datoViviendaId]);
    final result =
        List<LstServPublico>.from(res.map((m) => LstServPublico.fromJson(m)))
            .toList();

    return result;
  }
}
