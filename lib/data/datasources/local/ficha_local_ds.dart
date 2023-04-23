import '../../../domain/entities/ficha_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/ficha_model.dart';

abstract class FichaLocalDataSource {
  Future<FichaModel?> createFicha(FichaEntity ficha);
}

class FichaLocalDataSourceImpl implements FichaLocalDataSource {
  @override
  Future<FichaModel?> createFicha(FichaEntity ficha) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db
        .query('Ficha', where: 'userName = ?', whereArgs: [ficha.userName]);

    if (res.isEmpty) return null;

    final resultMap = {for (var e in res[0].entries) e.key: e.value};
    final result = FichaModel.fromJson(resultMap);
    return result;
  }
}
