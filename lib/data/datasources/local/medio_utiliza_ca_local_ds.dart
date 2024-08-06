import '../../../core/constants.dart';
import '../../models/medio_utiliza_ca.dart';

abstract class MedioUtilizaCALocalDataSource {
  Future<List<MedioUtilizaCAModel>> getMediosUtilizaCA();
  Future<int> saveMedioUtilizaCA(MedioUtilizaCAModel medioUtilizaCA);
  Future<int> saveUbicacionMediosUtilizaCA(
      int ubicacionId, List<LstMediosUtilizaCA> lstMediosUtilizaCA);
  Future<List<LstMediosUtilizaCA>> getUbicacionMediosUtilizaCA(
      int? ubicacionId);
}

class MedioUtilizaCALocalDataSourceImpl
    implements MedioUtilizaCALocalDataSource {
  @override
  Future<List<MedioUtilizaCAModel>> getMediosUtilizaCA() async {
    final res = await supabase.from('MediosUtiliza_CentroAtencion').select();
    final mediosUtilizaCADB = List<MedioUtilizaCAModel>.from(
        res.map((m) => MedioUtilizaCAModel.fromJson(m))).toList();

    return mediosUtilizaCADB;
  }

  @override
  Future<int> saveMedioUtilizaCA(MedioUtilizaCAModel medioUtilizaCA) async {
    final res = await supabase
        .from('MediosUtiliza_CentroAtencion')
        .insert(medioUtilizaCA.toJson());

    return res;
  }

  @override
  Future<List<LstMediosUtilizaCA>> getUbicacionMediosUtilizaCA(
      int? ubicacionId) async {
    final res = await supabase
        .from('Asp1_UbicacionMediosCentroAtencion')
        .select()
        .eq('Ubicacion_id', ubicacionId);

    final result = List<LstMediosUtilizaCA>.from(
        res.map((m) => LstMediosUtilizaCA.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveUbicacionMediosUtilizaCA(
      int ubicacionId, List<LstMediosUtilizaCA> lstMediosUtilizaCA) async {
    Batch batch = db.batch();
    batch.delete('Asp1_UbicacionMediosCentroAtencion',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);

    final ubicacionMediosUtilizaCA = lstMediosUtilizaCA
        .map((item) => UbicacionMediosUtilizaCA(
              ubicacionId: ubicacionId,
              medioUtilizaId: item.medioUtilizaId,
            ))
        .toList();

    for (final ubicacionMedioUtilizaCA in ubicacionMediosUtilizaCA) {
      batch.insert('Asp1_UbicacionMediosCentroAtencion',
          ubicacionMedioUtilizaCA.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
