import '../../../core/constants.dart';
import '../../models/tipo_vivienda.dart';

abstract class TipoViviendaLocalDataSource {
  Future<List<TipoViviendaModel>> getTiposVivienda();
  Future<int> saveTipoVivienda(TipoViviendaModel tipoVivienda);
}

class TipoViviendaLocalDataSourceImpl implements TipoViviendaLocalDataSource {
  @override
  Future<List<TipoViviendaModel>> getTiposVivienda() async {
    final res = await supabase.from('TiposVivienda_DatosVivienda').select();
    final result = List<TipoViviendaModel>.from(
        res.map((m) => TipoViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTipoVivienda(TipoViviendaModel tipoVivienda) async {
    final res = await supabase
        .from('TiposVivienda_DatosVivienda')
        .insert(tipoVivienda.toJson());

    return res;
  }
}
