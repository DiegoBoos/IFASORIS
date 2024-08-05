

import '../../models/tuberculo_platano.dart';

abstract class TuberculoPlatanoLocalDataSource {
  Future<List<TuberculoPlatanoModel>> getTuberculosPlatanos();
  Future<int> saveTuberculoPlatano(TuberculoPlatanoModel tuberculoPlatano);

  Future<int> saveUbicacionTuberculosPlatanos(
      int ubicacionId, List<LstTuberculo> lstTuberculos);

  Future<List<LstTuberculo>> getUbicacionTuberculosPlatanos(int? ubicacionId);
}

class TuberculoPlatanoLocalDataSourceImpl
    implements TuberculoPlatanoLocalDataSource {
  @override
  Future<List<TuberculoPlatanoModel>> getTuberculosPlatanos() async {
    final res = await supabase.from(.select()'TuberculosPlatanos_AspectosSocioEconomicos');
    final result = List<TuberculoPlatanoModel>.from(
        res.map((m) => TuberculoPlatanoModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTuberculoPlatano(
      TuberculoPlatanoModel tuberculoPlatano) async {
    final res = await supabase.from(.insert(
        'TuberculosPlatanos_AspectosSocioEconomicos',
        tuberculoPlatano.toJson());

    return res;
  }

  @override
  Future<int> saveUbicacionTuberculosPlatanos(
      int ubicacionId, List<LstTuberculo> lstTuberculos) async {
    Batch batch = db.batch();
    batch.delete('Asp1_UbicacionTuberculosPlatanos',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);

    final ubicacionTuberculosPlatanos = lstTuberculos
        .map((item) => UbicacionTuberculosPlatanos(
            tuberculoPlatanoId: item.tuberculoPlatanoId,
            ubicacionId: ubicacionId,
            otroTuberculoPlatano: item.otroTuberculoPlatano))
        .toList();

    for (final ubicacionTuberculoPlatano in ubicacionTuberculosPlatanos) {
      batch.insert('Asp1_UbicacionTuberculosPlatanos',
          ubicacionTuberculoPlatano.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstTuberculo>> getUbicacionTuberculosPlatanos(
      int? ubicacionId) async {
    final res = await supabase.from(.select()'Asp1_UbicacionTuberculosPlatanos',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);
    final result =
        List<LstTuberculo>.from(res.map((m) => LstTuberculo.fromJson(m)))
            .toList();

    return result;
  }
}
