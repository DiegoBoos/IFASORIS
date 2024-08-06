import '../../../core/constants.dart';
import '../../models/tipo_calendario.dart';

abstract class TipoCalendarioLocalDataSource {
  Future<List<TipoCalendarioModel>> getTiposCalendario();
  Future<int> saveTipoCalendario(TipoCalendarioModel tipoCalendario);
}

class TipoCalendarioLocalDataSourceImpl
    implements TipoCalendarioLocalDataSource {
  @override
  Future<List<TipoCalendarioModel>> getTiposCalendario() async {
    final res = await supabase
        .from('TiposCalendarios_AspectosSocioEconomicos')
        .select();
    final result = List<TipoCalendarioModel>.from(
        res.map((m) => TipoCalendarioModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTipoCalendario(TipoCalendarioModel tipoCalendario) async {
    final res = await supabase
        .from('TiposCalendarios_AspectosSocioEconomicos')
        .insert(tipoCalendario.toJson());

    return res;
  }
}
