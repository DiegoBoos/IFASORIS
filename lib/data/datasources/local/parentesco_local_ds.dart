import '../../../services/connection_sqlite_service.dart';
import '../../models/parentesco.dart';

abstract class ParentescoLocalDataSource {
  Future<List<ParentescoModel>> getParentescos();
  Future<int> saveParentesco(ParentescoModel parentesco);
}

class ParentescoLocalDataSourceImpl implements ParentescoLocalDataSource {
  @override
  Future<List<ParentescoModel>> getParentescos() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Parentesco_GrupoFamiliar');
    final result =
        List<ParentescoModel>.from(res.map((m) => ParentescoModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveParentesco(ParentescoModel parentesco) async {
    final db = await ConnectionSQLiteService.db;

    final res =
        await db.insert('Parentesco_GrupoFamiliar', parentesco.toJson());

    return res;
  }
}
