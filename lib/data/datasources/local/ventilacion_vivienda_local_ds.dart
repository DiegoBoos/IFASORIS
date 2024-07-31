import '../../../services/connection_sqlite_service.dart';
import '../../models/ventilacion_vivienda.dart';

abstract class VentilacionViviendaLocalDataSource {
  Future<List<VentilacionViviendaModel>> getVentilacionesVivienda();
  Future<int> saveVentilacionVivienda(
      VentilacionViviendaModel ventilacionVivienda);
}

class VentilacionViviendaLocalDataSourceImpl
    implements VentilacionViviendaLocalDataSource {
  @override
  Future<List<VentilacionViviendaModel>> getVentilacionesVivienda() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('VentilacionVivienda_DatosVivienda');
    final result = List<VentilacionViviendaModel>.from(
        res.map((m) => VentilacionViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveVentilacionVivienda(
      VentilacionViviendaModel ventilacionVivienda) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'VentilacionVivienda_DatosVivienda', ventilacionVivienda.toJson());

    return res;
  }
}
