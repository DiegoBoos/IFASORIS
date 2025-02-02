import '../../../services/connection_sqlite_service.dart';
import '../../models/ocupacion.dart';

abstract class OcupacionLocalDataSource {
  Future<List<OcupacionModel>> getOcupaciones();
  Future<int> saveOcupacion(OcupacionModel ocupacion);
}

class OcupacionLocalDataSourceImpl implements OcupacionLocalDataSource {
  @override
  Future<List<OcupacionModel>> getOcupaciones() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Ocupacion_GrupoFamiliar');
    final result =
        List<OcupacionModel>.from(res.map((m) => OcupacionModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveOcupacion(OcupacionModel ocupacion) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('Ocupacion_GrupoFamiliar', ocupacion.toJson());

    return res;
  }
}
