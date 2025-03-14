import '../../../domain/entities/etnia_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/etnia_model.dart';

abstract class EtniaLocalDataSource {
  Future<List<EtniaModel>> getEtnias();
  Future<int> saveEtnia(EtniaEntity etnia);
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
  Future<int> saveEtnia(EtniaEntity etnia) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('Etnia_GrupoFamiliar', etnia.toJson());

    return res;
  }
}
