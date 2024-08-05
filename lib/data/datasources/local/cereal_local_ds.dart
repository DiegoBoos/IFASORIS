import '../../../core/constants.dart';
import '../../models/cereal.dart';

abstract class CerealLocalDataSource {
  Future<List<CerealModel>> getCereales();
  Future<int> saveCereal(CerealModel cereal);
  Future<int> saveUbicacionCereales(
      int ubicacionId, List<LstCereal> lstCereales);
  Future<List<LstCereal>> getUbicacionCereales(int? ubicacionId);
}

class CerealLocalDataSourceImpl implements CerealLocalDataSource {
  @override
  Future<List<CerealModel>> getCereales() async {
    final res =
        await supabase.from('Cereales_AspectosSocioEconomicos').select();
    final result =
        List<CerealModel>.from(res.map((m) => CerealModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveCereal(CerealModel cereal) async {
    final res = await supabase
        .from('Cereales_AspectosSocioEconomicos')
        .insert(cereal.toJson());

    return res;
  }

  @override
  Future<int> saveUbicacionCereales(
      int ubicacionId, List<LstCereal> lstCereales) async {
    Batch batch = db.batch();
    batch.delete('Asp1_UbicacionCereales',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);

    final ubicacionCereales = lstCereales
        .map((item) => UbicacionCereales(
            cerealId: item.cerealId,
            ubicacionId: ubicacionId,
            otroCereal: item.otroCereal))
        .toList();

    for (final ubicacionCereal in ubicacionCereales) {
      batch.insert('Asp1_UbicacionCereales', ubicacionCereal.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstCereal>> getUbicacionCereales(int? ubicacionId) async {
    final res = await supabase
        .from('Asp1_UbicacionCereales')
        .select()
        .eq('Ubicacion_id', ubicacionId);
    final result =
        List<LstCereal>.from(res.map((m) => LstCereal.fromJson(m))).toList();

    return result;
  }
}
