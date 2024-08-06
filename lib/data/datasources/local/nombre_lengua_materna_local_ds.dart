import '../../../core/constants.dart';
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
    final res =
        await supabase.from('NombreLenguaMaterna_GrupoFamiliar').select();
    final result = List<NombreLenguaMaternaModel>.from(
        res.map((m) => NombreLenguaMaternaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveNombreLenguaMaterna(
      NombreLenguaMaternaModel nombreLenguaMaterna) async {
    final res = await supabase
        .from('NombreLenguaMaterna_GrupoFamiliar')
        .insert(nombreLenguaMaterna.toJson());

    return res;
  }
}
