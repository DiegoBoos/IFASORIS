import '../../../core/constants.dart';
import '../../models/servicio_solicitado.dart';

abstract class ServicioSolicitadoLocalDataSource {
  Future<List<ServicioSolicitadoModel>> getServiciosSolicitados();
  Future<int> saveServicioSolicitado(
      ServicioSolicitadoModel servicioSolicitado);

  Future<List<LstServicioSolicitado>> getLstServiciosSolicitados(
      int? cuidadoSaludCondRiesgoId);

  Future<int> saveServiciosSolicitados(int cuidadoSaludCondRiesgoId,
      List<LstServicioSolicitado> lstServiciosSolicitados);
}

class ServicioSolicitadoLocalDataSourceImpl
    implements ServicioSolicitadoLocalDataSource {
  @override
  Future<List<ServicioSolicitadoModel>> getServiciosSolicitados() async {
    final res = await supabase
        .from('ServiciosSolicitados_CuidadoSaludCondRiesgo')
        .select();
    final result = List<ServicioSolicitadoModel>.from(
        res.map((m) => ServicioSolicitadoModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveServicioSolicitado(
      ServicioSolicitadoModel servicioSolicitado) async {
    final res = await supabase
        .from('ServiciosSolicitados_CuidadoSaludCondRiesgo')
        .insert(servicioSolicitado.toJson());

    return res;
  }

  @override
  Future<List<LstServicioSolicitado>> getLstServiciosSolicitados(
      int? cuidadoSaludCondRiesgoId) async {
    final res = await supabase
        .from('Asp5_CuidadoSaludCondRiesgoServiciosSolicita')
        .select()
        .eq('CuidadoSaludCondRiesgo_id', cuidadoSaludCondRiesgoId);
    final result = List<LstServicioSolicitado>.from(
        res.map((m) => LstServicioSolicitado.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveServiciosSolicitados(int cuidadoSaludCondRiesgoId,
      List<LstServicioSolicitado> lstServiciosSolicitados) async {
    Batch batch = db.batch();
    batch.delete('Asp5_CuidadoSaludCondRiesgoServiciosSolicita',
        where: 'CuidadoSaludCondRiesgo_id = ?',
        whereArgs: [cuidadoSaludCondRiesgoId]);

    final cuidadoSaludCondRiesgoServiciosSolicitados = lstServiciosSolicitados
        .map((item) => CuidadoSaludCondRiesgoServiciosSolicitados(
            servicioSolicitadoId: item.servicioSolicitadoId,
            cuidadoSaludCondRiesgoId: cuidadoSaludCondRiesgoId))
        .toList();

    for (final cuidadoSaludCondRiesgoServicioSolicitado
        in cuidadoSaludCondRiesgoServiciosSolicitados) {
      batch.insert('Asp5_CuidadoSaludCondRiesgoServiciosSolicita',
          cuidadoSaludCondRiesgoServicioSolicitado.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
