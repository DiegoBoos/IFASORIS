import '../../../domain/entities/consumo_alcohol_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/consumo_alcohol_model.dart';

abstract class ConsumoAlcoholLocalDataSource {
  Future<List<ConsumoAlcoholModel>> getConsumosAlcohol();
  Future<int> saveConsumoAlcohol(ConsumoAlcoholEntity consumoAlcohol);
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
  Future<int> saveConsumoAlcohol(ConsumoAlcoholEntity consumoAlcohol) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'ConsumoAlcohol_EstilosVidaSaludable', consumoAlcohol.toJson());

    return res;
  }
}
