import '../../../domain/entities/pueblo_indigena_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/pueblo_indigena_model.dart';

abstract class PuebloIndigenaByDptoLocalDataSource {
  Future<List<PuebloIndigenaModel>> getPueblosIndigenasByDpto();
  Future<int> savePuebloIndigenaByDpto(PuebloIndigenaEntity puebloIndigena);
}

class PuebloIndigenaByDptoLocalDataSourceImpl
    implements PuebloIndigenaByDptoLocalDataSource {
  @override
  Future<List<PuebloIndigenaModel>> getPueblosIndigenasByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('PueblosIndigenas_DatosVivienda');
    final result = List<PuebloIndigenaModel>.from(
        res.map((m) => PuebloIndigenaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> savePuebloIndigenaByDpto(
      PuebloIndigenaEntity puebloIndigena) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'PueblosIndigenas_DatosVivienda', puebloIndigena.toJson());

    return res;
  }
}
