import '../../../domain/entities/piso_vivienda_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/piso_vivienda_model.dart';

abstract class PisoViviendaLocalDataSource {
  Future<List<PisoViviendaModel>> getPisosVivienda();
  Future<int> savePisoVivienda(PisoViviendaEntity pisoVivienda);
}

class PisoViviendaLocalDataSourceImpl implements PisoViviendaLocalDataSource {
  @override
  Future<List<PisoViviendaModel>> getPisosVivienda() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('PisosVivienda_DatosVivienda');
    final result = List<PisoViviendaModel>.from(
        res.map((m) => PisoViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> savePisoVivienda(PisoViviendaEntity pisoVivienda) async {
    final db = await ConnectionSQLiteService.db;

    final res =
        await db.insert('PisosVivienda_DatosVivienda', pisoVivienda.toJson());

    return res;
  }
}
