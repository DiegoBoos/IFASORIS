import '../../../domain/entities/verdura_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/verdura_model.dart';

abstract class VerduraByDptoLocalDataSource {
  Future<List<VerduraModel>> getVerdurasByDpto();
  Future<int> saveVerduraByDpto(VerduraEntity verdura);
}

class VerduraByDptoLocalDataSourceImpl implements VerduraByDptoLocalDataSource {
  @override
  Future<List<VerduraModel>> getVerdurasByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Verduras_AspectosSocioEconomicos');
    final result =
        List<VerduraModel>.from(res.map((m) => VerduraModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveVerduraByDpto(VerduraEntity verdura) async {
    final db = await ConnectionSQLiteService.db;

    final res =
        await db.insert('Verduras_AspectosSocioEconomicos', verdura.toJson());

    return res;
  }
}
