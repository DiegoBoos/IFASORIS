import '../../../core/constants.dart';
import '../../models/ultima_vez_inst_salud.dart';

abstract class UltimaVezInstSaludLocalDataSource {
  Future<List<UltimaVezInstSaludModel>> getUltimasVecesInstSalud();
  Future<int> saveUltimaVezInstSalud(
      UltimaVezInstSaludModel ultimaVezInstSalud);
}

class UltimaVezInstSaludLocalDataSourceImpl
    implements UltimaVezInstSaludLocalDataSource {
  @override
  Future<List<UltimaVezInstSaludModel>> getUltimasVecesInstSalud() async {
    final res = await supabase
        .from('UltimaVezInstSalud_CuidadoSaludCondRiesgo')
        .select();
    final result = List<UltimaVezInstSaludModel>.from(
        res.map((m) => UltimaVezInstSaludModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveUltimaVezInstSalud(
      UltimaVezInstSaludModel ultimaVezInstSalud) async {
    final res = await supabase
        .from('UltimaVezInstSalud_CuidadoSaludCondRiesgo')
        .insert(ultimaVezInstSalud.toJson());

    return res;
  }
}
