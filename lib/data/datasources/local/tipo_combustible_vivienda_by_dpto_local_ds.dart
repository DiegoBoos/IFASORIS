import '../../../domain/entities/tipo_combustible_vivienda_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/tipo_combustible_vivienda_model.dart';

abstract class TipoCombustibleViviendaByDptoLocalDataSource {
  Future<List<TipoCombustibleViviendaModel>>
      getTiposCombustibleViviendaByDpto();
  Future<int> saveTipoCombustibleViviendaByDpto(
      TipoCombustibleViviendaEntity tipoCombustibleViviendaByDpto);
}

class TipoCombustibleViviendaByDptoLocalDataSourceImpl
    implements TipoCombustibleViviendaByDptoLocalDataSource {
  @override
  Future<List<TipoCombustibleViviendaModel>>
      getTiposCombustibleViviendaByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('TiposCombustibleVivienda_DatosVivienda');
    final result = List<TipoCombustibleViviendaModel>.from(
        res.map((m) => TipoCombustibleViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTipoCombustibleViviendaByDpto(
      TipoCombustibleViviendaEntity tipoCombustibleViviendaByDpto) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('TiposCombustibleVivienda_DatosVivienda',
        tipoCombustibleViviendaByDpto.toJson());

    return res;
  }
}
