import '../../../domain/entities/piso_vivienda_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/piso_vivienda_model.dart';

abstract class PisoViviendaByDptoLocalDataSource {
  Future<List<PisoViviendaModel>> getPisosViviendaByDpto();
  Future<int> savePisoViviendaByDpto(PisoViviendaEntity pisoVivienda);
}

class PisoViviendaByDptoLocalDataSourceImpl
    implements PisoViviendaByDptoLocalDataSource {
  @override
  Future<List<PisoViviendaModel>> getPisosViviendaByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('PisosVivienda_DatosVivienda');
    final result = List<PisoViviendaModel>.from(
        res.map((m) => PisoViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> savePisoViviendaByDpto(PisoViviendaEntity pisoVivienda) async {
    final db = await ConnectionSQLiteService.db;

    final res =
        await db.insert('PisosVivienda_DatosVivienda', pisoVivienda.toJson());

    return res;
  }
}
