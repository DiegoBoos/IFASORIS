import '../../../services/connection_sqlite_service.dart';
import '../../models/consumo_alcohol.dart';

abstract class ConsumoAlcoholLocalDataSource {
  Future<List<ConsumoAlcoholModel>> getConsumosAlcohol();
  Future<int> saveConsumoAlcohol(ConsumoAlcoholModel consumoAlcohol);
}

class ConsumoAlcoholLocalDataSourceImpl
    implements ConsumoAlcoholLocalDataSource {
  @override
  Future<List<ConsumoAlcoholModel>> getConsumosAlcohol() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('ConsumoAlcohol_EstilosVidaSaludable');
    final result = List<ConsumoAlcoholModel>.from(
        res.map((m) => ConsumoAlcoholModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveConsumoAlcohol(ConsumoAlcoholModel consumoAlcohol) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'ConsumoAlcohol_EstilosVidaSaludable', consumoAlcohol.toJson());

    return res;
  }
}
