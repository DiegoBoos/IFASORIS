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
    final res = await db.query('CerealByDpto');
    final result =
        List<CerealModel>.from(res.map((m) => CerealModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveCerealByDpto(CerealEntity cereal) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('CerealByDpto', cereal.toJson());

    return res;
  }
}
