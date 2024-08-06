import '../../../core/constants.dart';
import '../../models/servicio_publico_vivienda.dart';

abstract class ServicioPublicoViviendaLocalDataSource {
  Future<List<ServicioPublicoViviendaModel>> getServiciosPublicos();
  Future<int> saveServicioPublicoVivienda(
      ServicioPublicoViviendaModel servicioPublicoVivienda);

  Future<int> saveServiciosPublicosVivienda(
      int datoViviendaId, List<LstServPublico> lstServPublico);

  Future<List<LstServPublico>> getServiciosPublicosVivienda(
      int? datoViviendaId);
}

class ServicioPublicoViviendaLocalDataSourceImpl
    implements ServicioPublicoViviendaLocalDataSource {
  @override
  Future<List<ServicioPublicoViviendaModel>> getServiciosPublicos() async {
    final res =
        await supabase.from('ServiciosPublicosVivienda_DatosVivienda').select();
    final result = List<ServicioPublicoViviendaModel>.from(
        res.map((m) => ServicioPublicoViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveServicioPublicoVivienda(
      ServicioPublicoViviendaModel servicioPublicoVivienda) async {
    final res = await supabase
        .from('ServiciosPublicosVivienda_DatosVivienda')
        .insert(servicioPublicoVivienda.toJson());

    return res;
  }

  @override
  Future<int> saveServiciosPublicosVivienda(
      int datoViviendaId, List<LstServPublico> lstServPublico) async {
    Batch batch = db.batch();
    batch.delete('Asp2_DatosViviendaServiciosPublicos',
        where: 'DatoVivienda_id = ?', whereArgs: [datoViviendaId]);

    final viviendaServiciosPublicos = lstServPublico
        .map((item) => ViviendaServiciosPublicos(
            servicioPublicoViviendaId: item.servicioPublicoViviendaId,
            datoViviendaId: datoViviendaId))
        .toList();

    for (final viviendaServicioPublico in viviendaServiciosPublicos) {
      batch.insert('Asp2_DatosViviendaServiciosPublicos',
          viviendaServicioPublico.toJson());
    }

    final res = await batch.commit();

    return res.length;
  }

  @override
  Future<List<LstServPublico>> getServiciosPublicosVivienda(
      int? datoViviendaId) async {
    final res = await supabase
        .from('Asp2_DatosViviendaServiciosPublicos')
        .select()
        .eq('DatoVivienda_id', datoViviendaId);
    final result =
        List<LstServPublico>.from(res.map((m) => LstServPublico.fromJson(m)))
            .toList();

    return result;
  }
}
