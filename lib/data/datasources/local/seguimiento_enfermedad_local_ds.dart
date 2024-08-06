import '../../../core/constants.dart';
import '../../models/seguimiento_enfermedad.dart';

abstract class SeguimientoEnfermedadLocalDataSource {
  Future<List<SeguimientoEnfermedadModel>> getSeguimientoEnfermedades();
  Future<int> saveSeguimientoEnfermedad(
      SeguimientoEnfermedadModel seguimientoEnfermedad);
}

class SeguimientoEnfermedadLocalDataSourceImpl
    implements SeguimientoEnfermedadLocalDataSource {
  @override
  Future<List<SeguimientoEnfermedadModel>> getSeguimientoEnfermedades() async {
    final res = await supabase
        .from('SeguimientoEnfermedades_CuidadoSaludCondRiesgo')
        .select();
    final result = List<SeguimientoEnfermedadModel>.from(
        res.map((m) => SeguimientoEnfermedadModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveSeguimientoEnfermedad(
      SeguimientoEnfermedadModel seguimientoEnfermedad) async {
    final res = await supabase
        .from('SeguimientoEnfermedades_CuidadoSaludCondRiesgo')
        .insert(seguimientoEnfermedad.toJson());

    return res;
  }
}
