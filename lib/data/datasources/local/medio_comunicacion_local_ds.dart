import '../../../core/constants.dart';
import '../../models/medio_comunicacion.dart';

abstract class MedioComunicacionLocalDataSource {
  Future<List<MedioComunicacionModel>> getMediosComunicacion();
  Future<int> saveMedioComunicacion(MedioComunicacionModel medioComunicacion);

  Future<int> saveUbicacionMediosComunicacion(
      int ubicacionId, List<LstMediosComunica> lstMediosComunica);

  Future<List<LstMediosComunica>> getUbicacionMediosComunicacion(
      int? ubicacionId);
}

class MedioComunicacionLocalDataSourceImpl
    implements MedioComunicacionLocalDataSource {
  @override
  Future<List<MedioComunicacionModel>> getMediosComunicacion() async {
    final res = await supabase.from('MediosComunicacion').select();
    final mediosComunicacionDB = List<MedioComunicacionModel>.from(
        res.map((m) => MedioComunicacionModel.fromJson(m))).toList();

    return mediosComunicacionDB;
  }

  @override
  Future<int> saveMedioComunicacion(
      MedioComunicacionModel medioComunicacion) async {
    final res = await supabase
        .from('MediosComunicacion')
        .insert(medioComunicacion.toJson());

    return res;
  }

  @override
  Future<int> saveUbicacionMediosComunicacion(
      int ubicacionId, List<LstMediosComunica> lstMediosComunica) async {
    Batch batch = db.batch();
    batch.delete('Asp1_UbicacionMediosComunicacion',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);

    final ubicacionMediosComunicacion = lstMediosComunica
        .map((item) => UbicacionMediosComunicacion(
            medioComunicacionId: item.medioComunicacionId,
            ubicacionId: ubicacionId))
        .toList();

    for (final ubicacionMedioComunicacion in ubicacionMediosComunicacion) {
      batch.insert('Asp1_UbicacionMediosComunicacion',
          ubicacionMedioComunicacion.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstMediosComunica>> getUbicacionMediosComunicacion(
      int? ubicacionId) async {
    final res = await supabase
        .from('Asp1_UbicacionMediosComunicacion')
        .select()
        .eq('Ubicacion_id', ubicacionId);
    final ubicacionMediosComunicacionDB = List<LstMediosComunica>.from(
        res.map((m) => LstMediosComunica.fromJson(m))).toList();

    return ubicacionMediosComunicacionDB;
  }
}
