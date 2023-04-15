import '../../../domain/entities/cereal_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/cereal_model.dart';

abstract class CerealByDptoLocalDataSource {
  Future<List<CerealModel>> getCerealesByDpto();
  Future<int> saveCerealByDpto(CerealEntity cereal);
}

class CerealByDptoLocalDataSourceImpl implements CerealByDptoLocalDataSource {
  @override
  Future<List<CerealModel>> getCerealesByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Cereales_AspectosSocioEconomicos');
    final result =
        List<CerealModel>.from(res.map((m) => CerealModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveCerealByDpto(CerealEntity cereal) async {
    final db = await ConnectionSQLiteService.db;

    final res =
        await db.insert('Cereales_AspectosSocioEconomicos', cereal.toJson());

    return res;
  }
}
