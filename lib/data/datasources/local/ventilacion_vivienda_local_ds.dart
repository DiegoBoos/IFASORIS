import '../../../domain/entities/ventilacion_vivienda_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/ventilacion_vivienda_model.dart';

abstract class VentilacionViviendaLocalDataSource {
  Future<List<VentilacionViviendaModel>> getVentilacionesVivienda();
  Future<int> saveVentilacionVivienda(
      VentilacionViviendaEntity ventilacionVivienda);
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
      VentilacionViviendaEntity ventilacionVivienda) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'VentilacionVivienda_DatosVivienda', ventilacionVivienda.toJson());

    return res;
  }
}
