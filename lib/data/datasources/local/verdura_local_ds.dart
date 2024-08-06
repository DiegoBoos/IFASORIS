import '../../../core/constants.dart';
import '../../models/verdura.dart';

abstract class VerduraLocalDataSource {
  Future<List<VerduraModel>> getVerduras();
  Future<int> saveVerdura(VerduraModel verdura);

  Future<int> saveUbicacionVerduras(
      int ubicacionId, List<LstVerdura> lstVerduras);

  Future<List<LstVerdura>> getUbicacionVerduras(int? ubicacionId);
}

class VerduraLocalDataSourceImpl implements VerduraLocalDataSource {
  @override
  Future<List<VerduraModel>> getVerduras() async {
    final res =
        await supabase.from('Verduras_AspectosSocioEconomicos').select();
    final result =
        List<VerduraModel>.from(res.map((m) => VerduraModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveVerdura(VerduraModel verdura) async {
    final res = await supabase
        .from('Verduras_AspectosSocioEconomicos')
        .insert(verdura.toJson());

    return res;
  }

  @override
  Future<int> saveUbicacionVerduras(
      int ubicacionId, List<LstVerdura> lstVerduras) async {
    Batch batch = db.batch();
    batch.delete('Asp1_UbicacionVerduras',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);

    final ubicacionVerduras = lstVerduras
        .map((item) => UbicacionVerduras(
            verduraId: item.verduraId,
            ubicacionId: ubicacionId,
            otroVerdura: item.otroVerdura))
        .toList();

    for (final ubicacionVerdura in ubicacionVerduras) {
      batch.insert('Asp1_UbicacionVerduras', ubicacionVerdura.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstVerdura>> getUbicacionVerduras(int? ubicacionId) async {
    final res = await supabase
        .from('Asp1_UbicacionVerduras')
        .select()
        .eq('Ubicacion_id', ubicacionId);
    final result =
        List<LstVerdura>.from(res.map((m) => LstVerdura.fromJson(m))).toList();

    return result;
  }
}
