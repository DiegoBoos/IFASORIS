import '../../../core/constants.dart';
import '../../models/condicion_nutricional.dart';

abstract class CondicionNutricionalLocalDataSource {
  Future<List<CondicionNutricionalModel>> getCondicionesNutricionales();
  Future<int> saveCondicionNutricional(
      CondicionNutricionalModel condicionNutricional);
}

class CondicionNutricionalLocalDataSourceImpl
    implements CondicionNutricionalLocalDataSource {
  @override
  Future<List<CondicionNutricionalModel>> getCondicionesNutricionales() async {
    final res = await supabase
        .from('CondicionesNutricionales_CuidadoSaludCondRiesgo')
        .select();
    final result = List<CondicionNutricionalModel>.from(
        res.map((m) => CondicionNutricionalModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveCondicionNutricional(
      CondicionNutricionalModel condicionNutricional) async {
    final res = await supabase
        .from('CondicionesNutricionales_CuidadoSaludCondRiesgo')
        .insert(condicionNutricional.toJson());

    return res;
  }
}
