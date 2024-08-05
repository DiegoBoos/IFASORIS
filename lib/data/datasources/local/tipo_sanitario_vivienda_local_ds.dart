

import '../../models/tipo_sanitario_vivienda.dart';

abstract class TipoSanitarioViviendaLocalDataSource {
  Future<List<TipoSanitarioViviendaModel>> getTiposSanitario();
  Future<int> saveTipoSanitarioVivienda(
      TipoSanitarioViviendaModel tipoSanitarioVivienda);

  Future<int> saveTiposSanitarioVivienda(
      int datoViviendaId, List<LstTipoSanitario> lstTipoSanitario);

  Future<List<LstTipoSanitario>> getTiposSanitarioVivienda(int? datoViviendaId);
}

class TipoSanitarioViviendaLocalDataSourceImpl
    implements TipoSanitarioViviendaLocalDataSource {
  @override
  Future<List<TipoSanitarioViviendaModel>> getTiposSanitario() async {
    final res = await supabase.from(.select()'TiposSanitarioVivienda_DatosVivienda');
    final result = List<TipoSanitarioViviendaModel>.from(
        res.map((m) => TipoSanitarioViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTipoSanitarioVivienda(
      TipoSanitarioViviendaModel tipoSanitarioVivienda) async {
    final res = await supabase.from(.insert(
        'TiposSanitarioVivienda_DatosVivienda', tipoSanitarioVivienda.toJson());

    return res;
  }

  @override
  Future<int> saveTiposSanitarioVivienda(
      int datoViviendaId, List<LstTipoSanitario> lstTipoSanitario) async {
    Batch batch = db.batch();
    batch.delete('Asp2_DatosViviendaTiposSanitario',
        where: 'DatoVivienda_id = ?', whereArgs: [datoViviendaId]);

    final viviendaTiposSanitario = lstTipoSanitario
        .map((item) => ViviendaTiposSanitario(
            tipoSanitarioViviendaId: item.tipoSanitarioViviendaId,
            datoViviendaId: datoViviendaId,
            otroTipoSanitario: item.otroTipoSanitario))
        .toList();

    for (final viviendaTipoSanitario in viviendaTiposSanitario) {
      batch.insert(
          'Asp2_DatosViviendaTiposSanitario', viviendaTipoSanitario.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstTipoSanitario>> getTiposSanitarioVivienda(
      int? datoViviendaId) async {
    final res = await supabase.from(.select()'Asp2_DatosViviendaTiposSanitario',
        where: 'DatoVivienda_id = ?', whereArgs: [datoViviendaId]);
    final result = List<LstTipoSanitario>.from(
        res.map((m) => LstTipoSanitario.fromJson(m))).toList();

    return result;
  }
}
