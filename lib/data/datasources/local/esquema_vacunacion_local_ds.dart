import '../../../core/constants.dart';
import '../../models/esquema_vacunacion.dart';

abstract class EsquemaVacunacionLocalDataSource {
  Future<List<EsquemaVacunacionModel>> getEsquemasVacunacion();
  Future<int> saveEsquemaVacunacion(EsquemaVacunacionModel esquemaVacunacion);
}

class EsquemaVacunacionLocalDataSourceImpl
    implements EsquemaVacunacionLocalDataSource {
  @override
  Future<List<EsquemaVacunacionModel>> getEsquemasVacunacion() async {
    final res = await supabase
        .from('EsquemasVacunacion_CuidadoSaludCondRiesgo')
        .select();
    final result = List<EsquemaVacunacionModel>.from(
        res.map((m) => EsquemaVacunacionModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveEsquemaVacunacion(
      EsquemaVacunacionModel esquemaVacunacion) async {
    final res = await supabase
        .from('EsquemasVacunacion_CuidadoSaludCondRiesgo')
        .insert(esquemaVacunacion.toJson());

    return res;
  }
}
