import '../../../core/constants.dart';
import '../../models/tratamiento_agua_vivienda.dart';

abstract class TratamientoAguaViviendaLocalDataSource {
  Future<List<TratamientoAguaViviendaModel>> getTratamientosAgua();
  Future<int> saveTratamientoAguaVivienda(
      TratamientoAguaViviendaModel tratamientoAguaVivienda);

  Future<int> saveTmtoAguasVivienda(
      int datoViviendaId, List<LstTmtoAgua> lstTmtoAgua);

  Future<List<LstTmtoAgua>> getTratamientosAguaVivienda(int? datoViviendaId);
}

class TratamientoAguaViviendaLocalDataSourceImpl
    implements TratamientoAguaViviendaLocalDataSource {
  @override
  Future<List<TratamientoAguaViviendaModel>> getTratamientosAgua() async {
    final res =
        await supabase.from('TratamientoAguaVivienda_DatosVivienda').select();
    final result = List<TratamientoAguaViviendaModel>.from(
        res.map((m) => TratamientoAguaViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTratamientoAguaVivienda(
      TratamientoAguaViviendaModel tratamientoAguaVivienda) async {
    final res = await supabase
        .from('TratamientoAguaVivienda_DatosVivienda')
        .insert(tratamientoAguaVivienda.toJson());

    return res;
  }

  @override
  Future<int> saveTmtoAguasVivienda(
      int datoViviendaId, List<LstTmtoAgua> lstTmtoAgua) async {
    Batch batch = db.batch();
    batch.delete('Asp2_DatosViviendaTratamientosAgua',
        where: 'DatoVivienda_id = ?', whereArgs: [datoViviendaId]);

    final viviendaTratamientosAgua = lstTmtoAgua
        .map((item) => ViviendaTratamientosAgua(
            tratamientoAguaViviendaId: item.tratamientoAguaViviendaId,
            datoViviendaId: datoViviendaId,
            otroTratamientoAgua: item.otroTratamientoAgua))
        .toList();

    for (final viviendaTratamientoAgua in viviendaTratamientosAgua) {
      batch.insert('Asp2_DatosViviendaTratamientosAgua',
          viviendaTratamientoAgua.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstTmtoAgua>> getTratamientosAguaVivienda(
      int? datoViviendaId) async {
    final res = await supabase
        .from('Asp2_DatosViviendaTratamientosAgua')
        .select()
        .eq('DatoVivienda_id', datoViviendaId);
    final result =
        List<LstTmtoAgua>.from(res.map((m) => LstTmtoAgua.fromJson(m)))
            .toList();

    return result;
  }
}
