

import '../../models/tipo_combustible_vivienda.dart';

abstract class TipoCombustibleViviendaLocalDataSource {
  Future<List<TipoCombustibleViviendaModel>> getTiposCombustible();
  Future<int> saveTipoCombustibleVivienda(
      TipoCombustibleViviendaModel tipoCombustibleVivienda);

  Future<int> saveTiposCombustibleVivienda(
      int datoViviendaId, List<LstTipoCombustible> lstTipoCombustible);

  Future<List<LstTipoCombustible>> getTiposCombustibleVivienda(
      int? datoViviendaId);
}

class TipoCombustibleViviendaLocalDataSourceImpl
    implements TipoCombustibleViviendaLocalDataSource {
  @override
  Future<List<TipoCombustibleViviendaModel>> getTiposCombustible() async {
    final res = await supabase.from(.select()'TiposCombustibleVivienda_DatosVivienda');
    final result = List<TipoCombustibleViviendaModel>.from(
        res.map((m) => TipoCombustibleViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTipoCombustibleVivienda(
      TipoCombustibleViviendaModel tipoCombustibleVivienda) async {
    final res = await supabase.from(.insert(
        'TiposCombustibleVivienda_DatosVivienda',
        tipoCombustibleVivienda.toJson());

    return res;
  }

  @override
  Future<int> saveTiposCombustibleVivienda(
      int datoViviendaId, List<LstTipoCombustible> lstTipoCombustible) async {
    Batch batch = db.batch();
    batch.delete('Asp2_DatosViviendaTiposCombustible',
        where: 'DatoVivienda_id = ?', whereArgs: [datoViviendaId]);

    final viviendaTiposCombustible = lstTipoCombustible
        .map((item) => ViviendaTiposCombustible(
            tipoCombustibleViviendaId: item.tipoCombustibleViviendaId,
            datoViviendaId: datoViviendaId,
            otroTipoCombustible: item.otroTipoCombustible))
        .toList();

    for (final viviendaTipoCombustible in viviendaTiposCombustible) {
      batch.insert('Asp2_DatosViviendaTiposCombustible',
          viviendaTipoCombustible.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstTipoCombustible>> getTiposCombustibleVivienda(
      int? datoViviendaId) async {
    final res = await supabase.from(.select()'Asp2_DatosViviendaTiposCombustible',
        where: 'DatoVivienda_id = ?', whereArgs: [datoViviendaId]);
    final result = List<LstTipoCombustible>.from(
        res.map((m) => LstTipoCombustible.fromJson(m))).toList();

    return result;
  }
}
