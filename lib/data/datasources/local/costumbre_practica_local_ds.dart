import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/costumbre_practica.dart';

abstract class CostumbrePracticaLocalDataSource {
  Future<List<CostumbrePracticaModel>> getCostumbresPractica();
  Future<int> saveCostumbrePractica(CostumbrePracticaModel costumbrePractica);
}

class CostumbrePracticaLocalDataSourceImpl
    implements CostumbrePracticaLocalDataSource {
  @override
  Future<List<CostumbrePracticaModel>> getCostumbresPractica() async {
    try {
      final res = await supabase
          .from('CostumbresPractican_DimSocioCulturalPueblosIndigenas')
          .select();
      final result = List<CostumbrePracticaModel>.from(
          res.map((m) => CostumbrePracticaModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveCostumbrePractica(
      CostumbrePracticaModel costumbrePractica) async {
    try {
      final res = await supabase
          .from('CostumbresPractican_DimSocioCulturalPueblosIndigenas')
          .insert(costumbrePractica.toJson());

      return res;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
