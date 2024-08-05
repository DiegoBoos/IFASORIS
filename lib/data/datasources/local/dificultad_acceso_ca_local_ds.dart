import '../../../core/constants.dart';
import '../../models/dificultad_acceso_ca.dart';

abstract class DificultadAccesoCALocalDataSource {
  Future<List<DificultadAccesoCAModel>> getDificultadesAccesoCA();
  Future<int> saveDificultadAccesoCA(
      DificultadAccesoCAModel dificultadAccesoCA);

  Future<int> saveUbicacionDificultadesAcceso(int ubicacionId,
      List<LstDificultadAccesoAtencion> lstDificultadAccesoAtencion);

  Future<List<LstDificultadAccesoAtencion>> getUbicacionDificultadesAcceso(
      int? ubicacionId);
}

class DificultadAccesoCALocalDataSourceImpl
    implements DificultadAccesoCALocalDataSource {
  @override
  Future<List<DificultadAccesoCAModel>> getDificultadesAccesoCA() async {
    final res =
        await supabase.from('DificultadesAcceso_CentroAtencion').select();
    final result = List<DificultadAccesoCAModel>.from(
        res.map((m) => DificultadAccesoCAModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveDificultadAccesoCA(
      DificultadAccesoCAModel dificultadAccesoCA) async {
    final res = await supabase
        .from('DificultadesAcceso_CentroAtencion')
        .insert(dificultadAccesoCA.toJson());

    return res;
  }

  @override
  Future<int> saveUbicacionDificultadesAcceso(int ubicacionId,
      List<LstDificultadAccesoAtencion> lstDificultadAccesoAtencion) async {
    Batch batch = db.batch();
    batch.delete('Asp1_UbicacionDificultadAcceso',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);

    final ubicacionDificultadesAcceso = lstDificultadAccesoAtencion
        .map((item) => UbicacionDificultadAcceso(
            dificultadAccesoId: item.dificultaAccesoId,
            ubicacionId: ubicacionId))
        .toList();

    for (final ubicacionDificultadAcceso in ubicacionDificultadesAcceso) {
      batch.insert(
          'Asp1_UbicacionDificultadAcceso', ubicacionDificultadAcceso.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstDificultadAccesoAtencion>> getUbicacionDificultadesAcceso(
      int? ubicacionId) async {
    final res = await supabase
        .from('Asp1_UbicacionDificultadAcceso')
        .select()
        .eq('Ubicacion_id', ubicacionId);

    final result = List<LstDificultadAccesoAtencion>.from(
        res.map((m) => LstDificultadAccesoAtencion.fromJson(m))).toList();

    return result;
  }
}
