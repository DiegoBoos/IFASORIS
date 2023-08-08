import '../../../domain/entities/familia_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/familia_model.dart';

abstract class FamiliaLocalDataSource {
  Future<FamiliaEntity> createFamilia(FamiliaEntity familia);
  Future<List<FamiliaModel>> loadFamilias();
}

class FamiliaLocalDataSourceImpl implements FamiliaLocalDataSource {
  @override
  Future<FamiliaEntity> createFamilia(FamiliaEntity familia) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('Familia', familia.toJson());

    familia.familiaId = res;

    return familia;
  }

  @override
  Future<List<FamiliaModel>> loadFamilias() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Familia');
    final result =
        List<FamiliaModel>.from(res.map((m) => FamiliaModel.fromJson(m)))
            .toList();

    return result;
  }
}
