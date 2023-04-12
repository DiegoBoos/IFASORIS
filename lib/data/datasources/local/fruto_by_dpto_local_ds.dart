import '../../../domain/entities/fruto_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/fruto_model.dart';

abstract class FrutoByDptoLocalDataSource {
  Future<List<FrutoModel>> getFrutosByDpto();
  Future<int> saveFrutoByDpto(FrutoEntity fruto);
}

class FrutoByDptoLocalDataSourceImpl implements FrutoByDptoLocalDataSource {
  @override
  Future<List<FrutoModel>> getFrutosByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('FrutoByDpto');
    final result =
        List<FrutoModel>.from(res.map((m) => FrutoModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveFrutoByDpto(FrutoEntity fruto) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('FrutoByDpto', fruto.toJson());

    return res;
  }
}
