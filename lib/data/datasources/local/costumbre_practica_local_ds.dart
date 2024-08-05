import '../../../core/constants.dart';
import '../../models/costumbre_practica.dart';

abstract class CostumbrePracticaLocalDataSource {
  Future<List<CostumbrePracticaModel>> getCostumbresPractica();
  Future<int> saveCostumbrePractica(CostumbrePracticaModel costumbrePractica);
}

class CostumbrePracticaLocalDataSourceImpl
    implements CostumbrePracticaLocalDataSource {
  @override
  Future<List<CostumbrePracticaModel>> getCostumbresPractica() async {
    final res = await supabase
        .from('CostumbresPractican_DimSocioCulturalPueblosIndigenas')
        .select();
    final result = List<CostumbrePracticaModel>.from(
        res.map((m) => CostumbrePracticaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveCostumbrePractica(
      CostumbrePracticaModel costumbrePractica) async {
    final res = await supabase
        .from('CostumbresPractican_DimSocioCulturalPueblosIndigenas')
        .insert(costumbrePractica.toJson());

    return res;
  }
}
