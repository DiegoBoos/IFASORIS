import '../../models/lugar_vacunacion.dart';

abstract class LugarVacunacionLocalDataSource {
  Future<List<LugarVacunacionModel>> getLugaresVacunacion();
  Future<int> saveLugarVacunacion(LugarVacunacionModel lugarVacunacion);
}

class LugarVacunacionLocalDataSourceImpl
    implements LugarVacunacionLocalDataSource {
  @override
  Future<List<LugarVacunacionModel>> getLugaresVacunacion() async {
    final res = await supabase.from(.select()'LugaresVacunacion_CuidadoSaludCondRiesgo');
    final result = List<LugarVacunacionModel>.from(
        res.map((m) => LugarVacunacionModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveLugarVacunacion(LugarVacunacionModel lugarVacunacion) async {
    final res = await supabase.from(.insert(
        'LugaresVacunacion_CuidadoSaludCondRiesgo', lugarVacunacion.toJson());

    return res;
  }
}
