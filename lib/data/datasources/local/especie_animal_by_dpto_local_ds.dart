import '../../../domain/entities/especie_animal_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/especie_animal_model.dart';

abstract class EspecieAnimalByDptoLocalDataSource {
  Future<List<EspecieAnimalModel>> getEspeciesAnimalesByDpto();
  Future<int> saveEspecieAnimalByDpto(EspecieAnimalEntity especieAnimal);
}

class EspecieAnimalByDptoLocalDataSourceImpl
    implements EspecieAnimalByDptoLocalDataSource {
  @override
  Future<List<EspecieAnimalModel>> getEspeciesAnimalesByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('EspecieAnimalesCria_AspectosSocioEconomicos');
    final result = List<EspecieAnimalModel>.from(
        res.map((m) => EspecieAnimalModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveEspecieAnimalByDpto(EspecieAnimalEntity especieAnimal) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'EspecieAnimalesCria_AspectosSocioEconomicos', especieAnimal.toJson());

    return res;
  }
}
