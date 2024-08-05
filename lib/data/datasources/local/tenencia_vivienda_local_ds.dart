import '../../models/tenencia_vivienda.dart';

abstract class TenenciaViviendaLocalDataSource {
  Future<List<TenenciaViviendaModel>> getTenenciasVivienda();
  Future<int> saveTenenciaVivienda(TenenciaViviendaModel tenenciaVivienda);
}

class TenenciaViviendaLocalDataSourceImpl
    implements TenenciaViviendaLocalDataSource {
  @override
  Future<List<TenenciaViviendaModel>> getTenenciasVivienda() async {
    final res = await supabase.from(.select()'TenenciasVivienda_DatosVivienda');
    final result = List<TenenciaViviendaModel>.from(
        res.map((m) => TenenciaViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTenenciaVivienda(
      TenenciaViviendaModel tenenciaVivienda) async {
    final res = await supabase
        .from(
        .insert('TenenciasVivienda_DatosVivienda', tenenciaVivienda.toJson());

    return res;
  }
}
