import '../../../domain/entities/leguminosa_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/leguminosa_model.dart';

abstract class LeguminosaByDptoLocalDataSource {
  Future<List<LeguminosaModel>> getLeguminosasByDpto();
  Future<int> saveLeguminosaByDpto(LeguminosaEntity leguminosa);
}

class LeguminosaByDptoLocalDataSourceImpl
    implements LeguminosaByDptoLocalDataSource {
  @override
  Future<List<LeguminosaModel>> getLeguminosasByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('LeguminosaByDpto');
    final result =
        List<LeguminosaModel>.from(res.map((m) => LeguminosaModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveLeguminosaByDpto(LeguminosaEntity leguminosa) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('LeguminosaByDpto', leguminosa.toJson());

    return res;
  }
}
