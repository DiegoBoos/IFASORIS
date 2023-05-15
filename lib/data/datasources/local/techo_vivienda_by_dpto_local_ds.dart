import '../../../domain/entities/techo_vivienda_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/techo_vivienda_model.dart';

abstract class TechoViviendaByDptoLocalDataSource {
  Future<List<TechoViviendaModel>> getTechosViviendaByDpto();
  Future<int> saveTechoViviendaByDpto(TechoViviendaEntity techoVivienda);
}

class TechoViviendaByDptoLocalDataSourceImpl
    implements TechoViviendaByDptoLocalDataSource {
  @override
  Future<List<TechoViviendaModel>> getTechosViviendaByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('TechosVivienda_DatosVivienda');
    final result = List<TechoViviendaModel>.from(
        res.map((m) => TechoViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTechoViviendaByDpto(TechoViviendaEntity techoVivienda) async {
    final db = await ConnectionSQLiteService.db;

    final res =
        await db.insert('TechosVivienda_DatosVivienda', techoVivienda.toJson());

    return res;
  }
}
