import '../../../core/constants.dart';
import '../../models/fruto.dart';

abstract class FrutoLocalDataSource {
  Future<List<FrutoModel>> getFrutos();
  Future<int> saveFruto(FrutoModel fruto);
  Future<int> saveUbicacionFrutos(int ubicacionId, List<LstFruto> lstFrutos);
  Future<List<LstFruto>> getUbicacionFrutos(int? ubicacionId);
}

class FrutoLocalDataSourceImpl implements FrutoLocalDataSource {
  @override
  Future<List<FrutoModel>> getFrutos() async {
    final res = await supabase.from('Frutos_AspectosSocioEconomicos').select();
    final result =
        List<FrutoModel>.from(res.map((m) => FrutoModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveFruto(FrutoModel fruto) async {
    final res = await supabase
        .from('Frutos_AspectosSocioEconomicos')
        .insert(fruto.toJson());

    return res;
  }

  @override
  Future<int> saveUbicacionFrutos(
      int ubicacionId, List<LstFruto> lstFrutos) async {
    Batch batch = db.batch();
    batch.delete('Asp1_UbicacionFrutos',
        where: 'Ubicacion_id = ?', whereArgs: [ubicacionId]);

    final ubicacionFrutos = lstFrutos
        .map((item) =>
            UbicacionFrutos(frutoId: item.frutoId, ubicacionId: ubicacionId))
        .toList();

    for (final ubicacionFruto in ubicacionFrutos) {
      batch.insert('Asp1_UbicacionFrutos', ubicacionFruto.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstFruto>> getUbicacionFrutos(int? ubicacionId) async {
    final res = await supabase
        .from('Asp1_UbicacionFrutos')
        .select()
        .eq('Ubicacion_id', ubicacionId);
    final result =
        List<LstFruto>.from(res.map((m) => LstFruto.fromJson(m))).toList();

    return result;
  }
}
