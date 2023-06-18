import '../../../domain/entities/ocupacion_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/ocupacion_model.dart';

abstract class OcupacionLocalDataSource {
  Future<List<OcupacionModel>> getOcupaciones();
  Future<int> saveOcupacion(OcupacionEntity ocupacion);
}

class OcupacionLocalDataSourceImpl implements OcupacionLocalDataSource {
  @override
  Future<List<OcupacionModel>> getOcupaciones() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Ocupacioness_AspectosSocioEconomicos');
    final result =
        List<OcupacionModel>.from(res.map((m) => OcupacionModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveOcupacion(OcupacionEntity ocupacion) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'Ocupacioness_AspectosSocioEconomicos', ocupacion.toJson());

    return res;
  }
}
