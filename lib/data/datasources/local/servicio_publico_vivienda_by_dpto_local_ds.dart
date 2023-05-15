import '../../../domain/entities/servicio_publico_vivienda_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/servicio_publico_vivienda_model.dart';

abstract class ServicioPublicoViviendaByDptoLocalDataSource {
  Future<List<ServicioPublicoViviendaModel>>
      getServiciosPublicosViviendaByDpto();
  Future<int> saveServicioPublicoViviendaByDpto(
      ServicioPublicoViviendaEntity servicioPublicoVivienda);
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
}
