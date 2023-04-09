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
    final res = await db.query('ViaAcceso');
    final viasAccesoDB =
        List<ViaAccesoModel>.from(res.map((m) => ViaAccesoModel.fromJson(m)))
            .toList();

    return viasAccesoDB;
  }

  @override
  Future<int> saveViaAcceso(ViaAccesoEntity viaAcceso) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('ViaAcceso', viaAcceso.toJson());

    return res;
  }
}
