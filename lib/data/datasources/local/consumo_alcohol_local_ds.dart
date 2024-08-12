import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/consumo_alcohol.dart';

abstract class ConsumoAlcoholLocalDataSource {
  Future<List<ConsumoAlcoholModel>> getConsumosAlcohol();
  Future<int> saveConsumoAlcohol(ConsumoAlcoholModel consumoAlcohol);
}

class ConsumoAlcoholLocalDataSourceImpl
    implements ConsumoAlcoholLocalDataSource {
  @override
  Future<List<ConsumoAlcoholModel>> getConsumosAlcohol() async {
    try {
      final res =
          await supabase.from('ConsumoAlcohol_EstilosVidaSaludable').select();
      final result = List<ConsumoAlcoholModel>.from(
          res.map((m) => ConsumoAlcoholModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveConsumoAlcohol(ConsumoAlcoholModel consumoAlcohol) async {
    try {
      final res = await supabase
          .from('ConsumoAlcohol_EstilosVidaSaludable')
          .insert(consumoAlcohol.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
