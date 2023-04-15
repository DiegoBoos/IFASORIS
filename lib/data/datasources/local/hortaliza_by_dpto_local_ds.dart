import '../../../domain/entities/hortaliza_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/hortaliza_model.dart';

abstract class HortalizaByDptoLocalDataSource {
  Future<List<HortalizaModel>> getHortalizasByDpto();
  Future<int> saveHortalizaByDpto(HortalizaEntity hortaliza);
}

class HortalizaByDptoLocalDataSourceImpl
    implements HortalizaByDptoLocalDataSource {
  @override
  Future<List<HortalizaModel>> getHortalizasByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Hortalizas_AspectosSocioEconomicos');
    final result =
        List<HortalizaModel>.from(res.map((m) => HortalizaModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveHortalizaByDpto(HortalizaEntity hortaliza) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'Hortalizas_AspectosSocioEconomicos', hortaliza.toJson());

    return res;
  }
}
