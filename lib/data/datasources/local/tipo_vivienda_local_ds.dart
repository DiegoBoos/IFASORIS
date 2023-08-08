import '../../../domain/entities/tipo_vivienda_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/tipo_vivienda_model.dart';

abstract class TipoViviendaLocalDataSource {
  Future<List<TipoViviendaModel>> getTiposVivienda();
  Future<int> saveTipoVivienda(TipoViviendaEntity tipoVivienda);
}

class TipoViviendaLocalDataSourceImpl implements TipoViviendaLocalDataSource {
  @override
  Future<List<TipoViviendaModel>> getTiposVivienda() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('TiposVivienda_DatosVivienda');
    final result = List<TipoViviendaModel>.from(
        res.map((m) => TipoViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTipoVivienda(TipoViviendaEntity tipoVivienda) async {
    final db = await ConnectionSQLiteService.db;

    final res =
        await db.insert('TiposVivienda_DatosVivienda', tipoVivienda.toJson());

    return res;
  }
}
