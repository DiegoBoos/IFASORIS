import '../../../domain/entities/tenencia_vivienda_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/tenencia_vivienda_model.dart';

abstract class TenenciaViviendaByDptoLocalDataSource {
  Future<List<TenenciaViviendaModel>> getTenenciasViviendaByDpto();
  Future<int> saveTenenciaViviendaByDpto(
      TenenciaViviendaEntity tenenciaVivienda);
}

class TenenciaViviendaByDptoLocalDataSourceImpl
    implements TenenciaViviendaByDptoLocalDataSource {
  @override
  Future<List<TenenciaViviendaModel>> getTenenciasViviendaByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('TenenciasVivienda_DatosVivienda');
    final result = List<TenenciaViviendaModel>.from(
        res.map((m) => TenenciaViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTenenciaViviendaByDpto(
      TenenciaViviendaEntity tenenciaVivienda) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'TenenciasVivienda_DatosVivienda', tenenciaVivienda.toJson());

    return res;
  }
}
