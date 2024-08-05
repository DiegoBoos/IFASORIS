import '../../models/tipo_vivienda.dart';

abstract class TipoViviendaLocalDataSource {
  Future<List<TipoViviendaModel>> getTiposVivienda();
  Future<int> saveTipoVivienda(TipoViviendaModel tipoVivienda);
}

class TipoViviendaLocalDataSourceImpl implements TipoViviendaLocalDataSource {
  @override
  Future<List<TipoViviendaModel>> getTiposVivienda() async {
    final res = await supabase.from(.select()'TiposVivienda_DatosVivienda');
    final result = List<TipoViviendaModel>.from(
        res.map((m) => TipoViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTipoVivienda(TipoViviendaModel tipoVivienda) async {
    final res = await supabase
        .from(
        .insert('TiposVivienda_DatosVivienda', tipoVivienda.toJson());

    return res;
  }
}
