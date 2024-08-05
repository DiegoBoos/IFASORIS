import '../../../core/constants.dart';
import '../../models/especie_animal.dart';

abstract class EspecieAnimalLocalDataSource {
  Future<List<EspecieAnimalModel>> getEspeciesAnimales();
  Future<int> saveEspecieAnimal(EspecieAnimalModel especieAnimal);
  Future<int> saveUbicacionEspecieAnimalesCria(
      int ubicacionId, List<LstAnimalCria> lstAnimalCria);
  Future<List<LstAnimalCria>> getAsp1EspeciesAnimales(int? ubicacionId);
}

class EspecieAnimalLocalDataSourceImpl implements EspecieAnimalLocalDataSource {
  @override
  Future<List<EspecieAnimalModel>> getEspeciesAnimales() async {
    final res = await supabase
        .from('EspecieAnimalesCria_AspectosSocioEconomicos')
        .select();
    final result = List<EspecieAnimalModel>.from(
        res.map((m) => EspecieAnimalModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveEspecieAnimal(EspecieAnimalModel especieAnimal) async {
    final res = await supabase
        .from('EspecieAnimalesCria_AspectosSocioEconomicos')
        .insert(especieAnimal.toJson());

    return res;
  }

  @override
  Future<int> saveUbicacionEspecieAnimalesCria(
      int ubicacionId, List<LstAnimalCria> lstAnimalCria) async {
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
    final res = await supabase
        .from('Asp1_UbicacionEspecieAnimalesCria')
        .select()
        .eq('Ubicacion_id', ubicacionId);
    final result =
        List<LstAnimalCria>.from(res.map((m) => LstAnimalCria.fromJson(m)))
            .toList();

    return result;
  }
}
