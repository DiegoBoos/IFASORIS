import '../../../domain/entities/factor_riesgo_vivienda_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/factor_riesgo_vivienda_model.dart';

abstract class FactorRiesgoViviendaByDptoLocalDataSource {
  Future<List<FactorRiesgoViviendaModel>> getFactoresRiesgoViviendaByDpto();
  Future<int> saveFactorRiesgoViviendaByDpto(
      FactorRiesgoViviendaEntity factorRiesgoViviendaByDpto);
}

class FactorRiesgoViviendaByDptoLocalDataSourceImpl
    implements FactorRiesgoViviendaByDptoLocalDataSource {
  @override
  Future<List<FactorRiesgoViviendaModel>>
      getFactoresRiesgoViviendaByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('FactoresRiesgoVivienda_DatosVivienda');
    final result = List<FactorRiesgoViviendaModel>.from(
        res.map((m) => FactorRiesgoViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveFactorRiesgoViviendaByDpto(
      FactorRiesgoViviendaEntity factorRiesgoViviendaByDpto) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('FactoresRiesgoVivienda_DatosVivienda',
        factorRiesgoViviendaByDpto.toJson());

    return res;
  }
}
