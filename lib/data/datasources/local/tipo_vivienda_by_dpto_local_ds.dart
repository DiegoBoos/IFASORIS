import '../../../domain/entities/tipo_vivienda_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/tipo_vivienda_model.dart';

abstract class TipoViviendaByDptoLocalDataSource {
  Future<List<TipoViviendaModel>> getTiposViviendaByDpto();
  Future<int> saveTipoViviendaByDpto(TipoViviendaEntity tipoVivienda);
}

class TipoViviendaByDptoLocalDataSourceImpl
    implements TipoViviendaByDptoLocalDataSource {
  @override
  Future<List<TipoViviendaModel>> getTiposViviendaByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('TiposVivienda_DatosVivienda');
    final result = List<TipoViviendaModel>.from(
        res.map((m) => TipoViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTipoViviendaByDpto(TipoViviendaEntity tipoVivienda) async {
    final db = await ConnectionSQLiteService.db;

    final res =
        await db.insert('TiposVivienda_DatosVivienda', tipoVivienda.toJson());

    return res;
  }
}
