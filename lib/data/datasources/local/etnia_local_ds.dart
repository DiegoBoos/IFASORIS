import '../../../services/connection_sqlite_service.dart';
import '../../models/etnia.dart';

abstract class EtniaLocalDataSource {
  Future<List<EtniaModel>> getEtnias();
  Future<int> saveEtnia(EtniaModel etnia);
}

class EtniaLocalDataSourceImpl implements EtniaLocalDataSource {
  @override
  Future<List<EtniaModel>> getEtnias() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Etnia_GrupoFamiliar');
    final result =
        List<EtniaModel>.from(res.map((m) => EtniaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveEtnia(EtniaModel etnia) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('Etnia_GrupoFamiliar', etnia.toJson());

    return res;
  }
}
