import '../../../domain/entities/pueblo_indigena_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/pueblo_indigena_model.dart';

abstract class PuebloIndigenaLocalDataSource {
  Future<List<PuebloIndigenaModel>> getPueblosIndigenas();
  Future<int> savePuebloIndigena(PuebloIndigenaEntity puebloIndigena);
}

class PuebloIndigenaLocalDataSourceImpl
    implements PuebloIndigenaLocalDataSource {
  @override
  Future<List<PuebloIndigenaModel>> getPueblosIndigenas() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('PueblosIndigenas_GrupoFamiliar');
    final result = List<PuebloIndigenaModel>.from(
        res.map((m) => PuebloIndigenaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> savePuebloIndigena(PuebloIndigenaEntity puebloIndigena) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'PueblosIndigenas_GrupoFamiliar', puebloIndigena.toJson());

    return res;
  }
}
