import '../../../domain/entities/familia_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/familia_model.dart';

abstract class FamiliaLocalDataSource {
  Future<FamiliaModel?> createFamilia(FamiliaEntity familia);
}

class FamiliaLocalDataSourceImpl implements FamiliaLocalDataSource {
  @override
  Future<FamiliaModel?> createFamilia(FamiliaEntity familia) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.query('Familia',
        where: 'userName = ?', whereArgs: [familia.apellidosFlia]);

    if (res.isEmpty) return null;

    final resultMap = {for (var e in res[0].entries) e.key: e.value};
    final result = FamiliaModel.fromJson(resultMap);
    return result;
  }
}
