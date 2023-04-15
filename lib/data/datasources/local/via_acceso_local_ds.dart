import '../../../domain/entities/via_acceso_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/via_acceso_model.dart';

abstract class ViaAccesoLocalDataSource {
  Future<List<ViaAccesoModel>> getViasAcceso();
  Future<int> saveViaAcceso(ViaAccesoEntity viaAcceso);
}

class ViaAccesoLocalDataSourceImpl implements ViaAccesoLocalDataSource {
  @override
  Future<List<ViaAccesoModel>> getViasAcceso() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('ViasAcceso');
    final result =
        List<ViaAccesoModel>.from(res.map((m) => ViaAccesoModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveViaAcceso(ViaAccesoEntity viaAcceso) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('ViasAcceso', viaAcceso.toJson());

    return res;
  }
}
