import '../../../core/constants.dart';
import '../../models/dificultad_acceso_med_tradicional.dart';

abstract class DificultadAccesoMedTradicionalLocalDataSource {
  Future<List<DificultadAccesoMedTradicionalModel>>
      getDificultadesAccesoMedTradicional();
  Future<int> saveDificultadAccesoMedTradicional(
      DificultadAccesoMedTradicionalModel dificultadAccesoMedTradicional);

  Future<int> saveUbicacionAccesoMedTradicional(
      int ubicacionId,
      List<LstDificultadAccesoMedTradicional>
          lstDificultadAccesoMedTradicional);

  Future<List<LstDificultadAccesoMedTradicional>>
      getUbicacionDificultadesAccesoMedTradicional(int? ubicacionId);
}

class DificultadAccesoMedTradicionalLocalDataSourceImpl
    implements DificultadAccesoMedTradicionalLocalDataSource {
  @override
  Future<List<DificultadAccesoMedTradicionalModel>>
      getDificultadesAccesoMedTradicional() async {
    final res =
        await supabase.from('DificultadesAcceso_AccesoMedTradicional').select();
    final result = List<DificultadAccesoMedTradicionalModel>.from(
            res.map((m) => DificultadAccesoMedTradicionalModel.fromJson(m)))
        .toList();

    return result;
  }

  @override
  Future<int> saveDificultadAccesoMedTradicional(
      DificultadAccesoMedTradicionalModel
          dificultadAccesoMedTradicional) async {
    final res = await supabase
        .from('DificultadesAcceso_AccesoMedTradicional')
        .insert(dificultadAccesoMedTradicional.toJson());

    return res;
  }

  @override
  Future<int> saveUbicacionAccesoMedTradicional(
      int ubicacionId,
      List<LstDificultadAccesoMedTradicional>
          lstDificultadAccesoMedTradicional) async {
    Batch batch = db.batch();
    batch.delete('Asp1_UbicacionAccesoMedTradicional',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);

    final ubicacionDificultadesAccesoMedTradicional =
        lstDificultadAccesoMedTradicional
            .map((item) => UbicacionDificultadAccesoMedTradicional(
                dificultadAccesoMedTradId: item.dificultadAccesoMedTradId,
                ubicacionId: ubicacionId))
            .toList();

    for (final ubicacionDificultadAccesoMedTradicional
        in ubicacionDificultadesAccesoMedTradicional) {
      batch.insert('Asp1_UbicacionAccesoMedTradicional',
          ubicacionDificultadAccesoMedTradicional.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstDificultadAccesoMedTradicional>>
      getUbicacionDificultadesAccesoMedTradicional(int? ubicacionId) async {
    final res = await supabase
        .from('Asp1_UbicacionAccesoMedTradicional')
        .select()
        .eq('Ubicacion_id', ubicacionId);

    final result = List<LstDificultadAccesoMedTradicional>.from(
        res.map((m) => LstDificultadAccesoMedTradicional.fromJson(m))).toList();

    return result;
  }
}
