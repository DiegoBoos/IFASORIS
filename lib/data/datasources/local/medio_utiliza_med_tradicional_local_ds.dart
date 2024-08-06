import '../../../core/constants.dart';
import '../../models/medio_utiliza_med_tradicional.dart';

abstract class MedioUtilizaMedTradicionalLocalDataSource {
  Future<List<MedioUtilizaMedTradicionalModel>>
      getMediosUtilizaMedTradicional();
  Future<int> saveMedioUtilizaMedTradicional(
      MedioUtilizaMedTradicionalModel medioUtilizaMedTradicional);

  Future<int> saveUbicacionMediosMedTradicional(
      int ubicacionId, List<LstMediosMedTradicional> lstMediosMedTradicional);

  Future<List<LstMediosMedTradicional>> getUbicacionMediosUtilizaMedTradicional(
      int? ubicacionId);
}

class MedioUtilizaMedTradicionalLocalDataSourceImpl
    implements MedioUtilizaMedTradicionalLocalDataSource {
  @override
  Future<List<MedioUtilizaMedTradicionalModel>>
      getMediosUtilizaMedTradicional() async {
    final res =
        await supabase.from('MediosUtiliza_AccesoMedTradicional').select();
    final result = List<MedioUtilizaMedTradicionalModel>.from(
        res.map((m) => MedioUtilizaMedTradicionalModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveMedioUtilizaMedTradicional(
      MedioUtilizaMedTradicionalModel medioUtilizaMedTradicional) async {
    final res = await supabase
        .from('MediosUtiliza_AccesoMedTradicional')
        .insert(medioUtilizaMedTradicional.toJson());

    return res;
  }

  @override
  Future<int> saveUbicacionMediosMedTradicional(int ubicacionId,
      List<LstMediosMedTradicional> lstMediosMedTradicional) async {
    Batch batch = db.batch();
    batch.delete('Asp1_UbicacionMediosMedTradicional',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);

    final ubicacionMediosMedTradicional = lstMediosMedTradicional
        .map((item) => UbicacionMediosMedTradicional(
            medioUtilizaMedTradicionalId: item.medioUtilizaMedTradId,
            ubicacionId: ubicacionId))
        .toList();

    for (final ubicacionMedioMedTradicional in ubicacionMediosMedTradicional) {
      batch.insert('Asp1_UbicacionMediosMedTradicional',
          ubicacionMedioMedTradicional.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstMediosMedTradicional>> getUbicacionMediosUtilizaMedTradicional(
      int? ubicacionId) async {
    final res = await supabase
        .from('Asp1_UbicacionMediosMedTradicional')
        .select()
        .eq('Ubicacion_id', ubicacionId);
    final result = List<LstMediosMedTradicional>.from(
        res.map((m) => LstMediosMedTradicional.fromJson(m))).toList();

    return result;
  }
}
