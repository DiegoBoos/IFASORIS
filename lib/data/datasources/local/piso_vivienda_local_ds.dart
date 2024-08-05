

import '../../models/piso_vivienda.dart';

abstract class PisoViviendaLocalDataSource {
  Future<List<PisoViviendaModel>> getPisosVivienda();
  Future<int> savePisoVivienda(PisoViviendaModel pisoVivienda);
  Future<int> savePisosVivienda(int datoViviendaId, List<LstPiso> lstPiso);
  Future<List<LstPiso>> getPisosViviendaVivienda(int? datoViviendaId);
}

class PisoViviendaLocalDataSourceImpl implements PisoViviendaLocalDataSource {
  @override
  Future<List<PisoViviendaModel>> getPisosVivienda() async {
    final res = await supabase.from(.select()'PisosVivienda_DatosVivienda');
    final result = List<PisoViviendaModel>.from(
        res.map((m) => PisoViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> savePisoVivienda(PisoViviendaModel pisoVivienda) async {
    final res = await supabase
        .from(
        .insert('PisosVivienda_DatosVivienda', pisoVivienda.toJson());

    return res;
  }

  @override
  Future<List<LstPiso>> getPisosViviendaVivienda(int? datoViviendaId) async {
    final res = await supabase.from(.select()'Asp2_DatosViviendaPisos',
        where: 'DatoVivienda_id = ?', whereArgs: [datoViviendaId]);
    final result =
        List<LstPiso>.from(res.map((m) => LstPiso.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> savePisosVivienda(
      int datoViviendaId, List<LstPiso> lstPiso) async {
    Batch batch = db.batch();
    batch.delete('Asp2_DatosViviendaPisos',
        where: 'DatoVivienda_id = ?', whereArgs: [datoViviendaId]);

    final viviendaPisos = lstPiso
        .map((item) => ViviendaPisos(
            pisoViviendaId: item.pisoViviendaId,
            datoViviendaId: datoViviendaId,
            otroTipoPiso: item.otroTipoPiso))
        .toList();

    for (final viviendaPiso in viviendaPisos) {
      batch.insert('Asp2_DatosViviendaPisos', viviendaPiso.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }
}
