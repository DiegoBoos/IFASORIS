import '../../../services/connection_sqlite_service.dart';
import '../../models/costumbre_practica.dart';

abstract class CostumbrePracticaLocalDataSource {
  Future<List<CostumbrePracticaModel>> getCostumbresPractica();
  Future<int> saveCostumbrePractica(CostumbrePracticaModel costumbrePractica);
}

class CostumbrePracticaLocalDataSourceImpl
    implements CostumbrePracticaLocalDataSource {
  @override
  Future<List<CostumbrePracticaModel>> getCostumbresPractica() async {
    final db = await ConnectionSQLiteService.db;
    final res =
        await db.query('CostumbresPractican_DimSocioCulturalPueblosIndigenas');
    final result = List<CostumbrePracticaModel>.from(
        res.map((m) => CostumbrePracticaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveCostumbrePractica(
      CostumbrePracticaModel costumbrePractica) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'CostumbresPractican_DimSocioCulturalPueblosIndigenas',
        costumbrePractica.toJson());

    return res;
  }
}
