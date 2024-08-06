import '../../../core/constants.dart';
import '../../models/hortaliza.dart';

abstract class HortalizaLocalDataSource {
  Future<List<HortalizaModel>> getHortalizas();
  Future<int> saveHortaliza(HortalizaModel hortaliza);

  Future<int> saveUbicacionHortalizas(
      int ubicacionId, List<LstHortaliza> lstHortalizas);

  Future<List<LstHortaliza>> getUbicacionHortalizas(int? ubicacionId);
}

class HortalizaLocalDataSourceImpl implements HortalizaLocalDataSource {
  @override
  Future<List<HortalizaModel>> getHortalizas() async {
    final res =
        await supabase.from('Hortalizas_AspectosSocioEconomicos').select();
    final result =
        List<HortalizaModel>.from(res.map((m) => HortalizaModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveHortaliza(HortalizaModel hortaliza) async {
    final res = await supabase
        .from('Hortalizas_AspectosSocioEconomicos')
        .insert(hortaliza.toJson());

    return res;
  }

  @override
  Future<int> saveUbicacionHortalizas(
      int ubicacionId, List<LstHortaliza> lstHortalizas) async {
    Batch batch = db.batch();
    batch.delete('Asp1_UbicacionHortalizas',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);

    final ubicacionHortalizas = lstHortalizas
        .map((item) => UbicacionHortalizas(
            hortalizaId: item.hortalizaId,
            ubicacionId: ubicacionId,
            otroHortaliza: item.otroHortaliza))
        .toList();

    for (final ubicacionHortaliza in ubicacionHortalizas) {
      batch.insert('Asp1_UbicacionHortalizas', ubicacionHortaliza.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstHortaliza>> getUbicacionHortalizas(int? ubicacionId) async {
    final res = await supabase
        .from('Asp1_UbicacionHortalizas')
        .select()
        .eq('Ubicacion_id', ubicacionId);
    final result =
        List<LstHortaliza>.from(res.map((m) => LstHortaliza.fromJson(m)))
            .toList();

    return result;
  }
}
