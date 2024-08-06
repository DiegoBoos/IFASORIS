import '../../../core/constants.dart';
import '../../models/lugar_vacunacion.dart';

abstract class LugarVacunacionLocalDataSource {
  Future<List<LugarVacunacionModel>> getLugaresVacunacion();
  Future<int> saveLugarVacunacion(LugarVacunacionModel lugarVacunacion);
}

class LugarVacunacionLocalDataSourceImpl
    implements LugarVacunacionLocalDataSource {
  @override
  Future<List<LugarVacunacionModel>> getLugaresVacunacion() async {
    final res = await supabase
        .from('LugaresVacunacion_CuidadoSaludCondRiesgo')
        .select();
    final result = List<LugarVacunacionModel>.from(
        res.map((m) => LugarVacunacionModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveLugarVacunacion(LugarVacunacionModel lugarVacunacion) async {
    final res = await supabase
        .from('LugaresVacunacion_CuidadoSaludCondRiesgo')
        .insert(lugarVacunacion.toJson());

    return res;
  }
}
