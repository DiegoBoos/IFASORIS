

import '../../models/techo_vivienda.dart';

abstract class TechoViviendaLocalDataSource {
  Future<List<TechoViviendaModel>> getTechosVivienda();
  Future<int> saveTechoVivienda(TechoViviendaModel techoVivienda);

  Future<int> saveTechosVivienda(int datoViviendaId, List<LstTecho> lstTecho);

  Future<List<LstTecho>> getTechosViviendaVivienda(int? datoViviendaId);
}

class TechoViviendaLocalDataSourceImpl implements TechoViviendaLocalDataSource {
  @override
  Future<List<TechoViviendaModel>> getTechosVivienda() async {
    final res = await supabase.from(.select()'TechosVivienda_DatosVivienda');
    final result = List<TechoViviendaModel>.from(
        res.map((m) => TechoViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTechoVivienda(TechoViviendaModel techoVivienda) async {
    final res = await supabase
        .from(
        .insert('TechosVivienda_DatosVivienda', techoVivienda.toJson());

    return res;
  }

  @override
  Future<int> saveTechosVivienda(
      int datoViviendaId, List<LstTecho> lstTecho) async {
    Batch batch = db.batch();
    batch.delete('Asp2_DatosViviendaTechos',
        where: 'DatoVivienda_id = ?', whereArgs: [datoViviendaId]);

    final viviendaTechos = lstTecho
        .map((item) => ViviendaTechos(
            techoViviendaId: item.techoViviendaId,
            datoViviendaId: datoViviendaId,
            otroTipoTecho: item.otroTipoTecho))
        .toList();

    for (final viviendaTecho in viviendaTechos) {
      batch.insert('Asp2_DatosViviendaTechos', viviendaTecho.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstTecho>> getTechosViviendaVivienda(int? datoViviendaId) async {
    final res = await supabase.from(.select()'Asp2_DatosViviendaTechos',
        where: 'DatoVivienda_id = ?', whereArgs: [datoViviendaId]);
    final result =
        List<LstTecho>.from(res.map((m) => LstTecho.fromJson(m))).toList();

    return result;
  }
}
