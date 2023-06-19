import '../../../domain/entities/regimen_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/regimen_model.dart';

abstract class RegimenLocalDataSource {
  Future<List<RegimenModel>> getRegimenes();
  Future<int> saveRegimen(RegimenEntity regimen);
}

class RegimenLocalDataSourceImpl implements RegimenLocalDataSource {
  @override
  Future<List<RegimenModel>> getRegimenes() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Regimenes_GrupoFamiliar');
    final result =
        List<RegimenModel>.from(res.map((m) => RegimenModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveRegimen(RegimenEntity regimen) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('Regimenes_GrupoFamiliar', regimen.toJson());

    return res;
  }
}
