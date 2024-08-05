import '../../../core/constants.dart';
import '../../models/consumo_alcohol.dart';

abstract class ConsumoAlcoholLocalDataSource {
  Future<List<ConsumoAlcoholModel>> getConsumosAlcohol();
  Future<int> saveConsumoAlcohol(ConsumoAlcoholModel consumoAlcohol);
}

class ConsumoAlcoholLocalDataSourceImpl
    implements ConsumoAlcoholLocalDataSource {
  @override
  Future<List<ConsumoAlcoholModel>> getConsumosAlcohol() async {
    final res =
        await supabase.from('ConsumoAlcohol_EstilosVidaSaludable').select();
    final result = List<ConsumoAlcoholModel>.from(
        res.map((m) => ConsumoAlcoholModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveConsumoAlcohol(ConsumoAlcoholModel consumoAlcohol) async {
    final res = await supabase
        .from('ConsumoAlcohol_EstilosVidaSaludable')
        .insert(consumoAlcohol.toJson());

    return res;
  }
}
