import '../../models/tipo_calendario.dart';

abstract class TipoCalendarioLocalDataSource {
  Future<List<TipoCalendarioModel>> getTiposCalendario();
  Future<int> saveTipoCalendario(TipoCalendarioModel tipoCalendario);
}

class TipoCalendarioLocalDataSourceImpl
    implements TipoCalendarioLocalDataSource {
  @override
  Future<List<TipoCalendarioModel>> getTiposCalendario() async {
    final res = await supabase.from(.select()'TiposCalendarios_AspectosSocioEconomicos');
    final result = List<TipoCalendarioModel>.from(
        res.map((m) => TipoCalendarioModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTipoCalendario(TipoCalendarioModel tipoCalendario) async {
    final res = await supabase.from(.insert(
        'TiposCalendarios_AspectosSocioEconomicos', tipoCalendario.toJson());

    return res;
  }
}
