import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/especie_animal_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/especie_animal_model.dart';

abstract class EspecieAnimalByDptoLocalDataSource {
  Future<List<EspecieAnimalModel>> getEspeciesAnimalesByDpto();
  Future<int> saveEspecieAnimalByDpto(EspecieAnimalEntity especieAnimal);
  Future<int> saveUbicacionEspecieAnimalesCria(
      int ubicacionId, List<LstAnimalCria> lstAnimalCria);
  Future<List<LstAnimalCria>> getAsp1EspeciesAnimales(int? ubicacionId);
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

  @override
  Future<int> saveUbicacionEspecieAnimalesCria(
      int ubicacionId, List<LstAnimalCria> lstAnimalCria) async {
    final db = await ConnectionSQLiteService.db;

    Batch batch = db.batch();
    batch.delete('Asp1_UbicacionEspecieAnimalesCria',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);

    final ubicacionEspeciesAnimalesCria = lstAnimalCria
        .map((item) => UbicacionEspecieAnimalesCria(
            especieAnimalCriaId: item.especieAnimalCriaId,
            ubicacionId: ubicacionId))
        .toList();

    for (final ubicacionEspecieAnimalCria in ubicacionEspeciesAnimalesCria) {
      batch.insert('Asp1_UbicacionEspecieAnimalesCria',
          ubicacionEspecieAnimalCria.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstAnimalCria>> getAsp1EspeciesAnimales(int? ubicacionId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp1_UbicacionEspecieAnimalesCria',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);
    final result =
        List<LstAnimalCria>.from(res.map((m) => LstAnimalCria.fromJson(m)))
            .toList();

    return result;
  }
}
