

import '../../../core/constants.dart';
import '../../models/leguminosa.dart';

abstract class LeguminosaLocalDataSource {
  Future<List<LeguminosaModel>> getLeguminosas();
  Future<int> saveLeguminosa(LeguminosaModel leguminosa);

  Future<int> saveUbicacionLeguminosas(
      int ubicacionId, List<LstLeguminosa> lstLeguminosas);

  Future<List<LstLeguminosa>> getUbicacionLeguminosas(int? ubicacionId);
}

class LeguminosaLocalDataSourceImpl implements LeguminosaLocalDataSource {
  @override
  Future<List<LeguminosaModel>> getLeguminosas() async {
    final res = await supabase.from('Leguminosas_AspectosSocioEconomicos').select();
    final result =
        List<LeguminosaModel>.from(res.map((m) => LeguminosaModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveLeguminosa(LeguminosaModel leguminosa) async {
    final res = await supabase
        .from(
        .insert('Leguminosas_AspectosSocioEconomicos', leguminosa.toJson());

    return res;
  }

  @override
  Future<int> saveUbicacionLeguminosas(
      int ubicacionId, List<LstLeguminosa> lstLeguminosas) async {
    Batch batch = db.batch();
    batch.delete('Asp1_UbicacionLeguminosas',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);

    final ubicacionLeguminosas = lstLeguminosas
        .map((item) => UbicacionLeguminosas(
            leguminosaId: item.leguminosaId, ubicacionId: ubicacionId))
        .toList();

    for (final ubicacionLeguminosa in ubicacionLeguminosas) {
      batch.insert('Asp1_UbicacionLeguminosas', ubicacionLeguminosa.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstLeguminosa>> getUbicacionLeguminosas(int? ubicacionId) async {
    final res = await supabase.from('Asp1_UbicacionLeguminosas').select().eq('Ubicacion_id', ubicacionId);
    final result =
        List<LstLeguminosa>.from(res.map((m) => LstLeguminosa.fromJson(m)))
            .toList();

    return result;
  }
}
