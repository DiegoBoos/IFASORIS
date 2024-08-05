import '../../models/nombre_lengua_materna.dart';

abstract class NombreLenguaMaternaLocalDataSource {
  Future<List<NombreLenguaMaternaModel>> getNombresLenguasMaterna();
  Future<int> saveNombreLenguaMaterna(
      NombreLenguaMaternaModel nombreLenguaMaterna);
}

class NombreLenguaMaternaLocalDataSourceImpl
    implements NombreLenguaMaternaLocalDataSource {
  @override
  Future<List<NombreLenguaMaternaModel>> getNombresLenguasMaterna() async {
    final res = await supabase.from(.select()'NombreLenguaMaterna_GrupoFamiliar');
    final result = List<NombreLenguaMaternaModel>.from(
        res.map((m) => NombreLenguaMaternaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveNombreLenguaMaterna(
      NombreLenguaMaternaModel nombreLenguaMaterna) async {
    final res = await supabase.from(.insert(
        'NombreLenguaMaterna_GrupoFamiliar', nombreLenguaMaterna.toJson());

    return res;
  }
}
