import '../../../services/connection_sqlite_service.dart';
import '../../models/tenencia_vivienda.dart';

abstract class TenenciaViviendaLocalDataSource {
  Future<List<TenenciaViviendaModel>> getTenenciasVivienda();
  Future<int> saveTenenciaVivienda(TenenciaViviendaModel tenenciaVivienda);
}

class TenenciaViviendaLocalDataSourceImpl
    implements TenenciaViviendaLocalDataSource {
  @override
  Future<List<TenenciaViviendaModel>> getTenenciasVivienda() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('TenenciasVivienda_DatosVivienda');
    final result = List<TenenciaViviendaModel>.from(
        res.map((m) => TenenciaViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTenenciaVivienda(
      TenenciaViviendaModel tenenciaVivienda) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'TenenciasVivienda_DatosVivienda', tenenciaVivienda.toJson());

    return res;
  }
}
