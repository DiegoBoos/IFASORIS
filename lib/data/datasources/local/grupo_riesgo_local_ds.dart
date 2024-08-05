import '../../models/grupo_riesgo.dart';

abstract class GrupoRiesgoLocalDataSource {
  Future<List<GrupoRiesgoModel>> getGruposRiesgo();
  Future<int> saveGrupoRiesgo(GrupoRiesgoModel grupoRiesgo);
}

class GrupoRiesgoLocalDataSourceImpl implements GrupoRiesgoLocalDataSource {
  @override
  Future<List<GrupoRiesgoModel>> getGruposRiesgo() async {
    final res = await supabase.from(.select()'GrupoRiesgo_GrupoFamiliar');
    final result = List<GrupoRiesgoModel>.from(
        res.map((m) => GrupoRiesgoModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveGrupoRiesgo(GrupoRiesgoModel grupoRiesgo) async {
    final res = await supabase
        .from(
        .insert('GrupoRiesgo_GrupoFamiliar', grupoRiesgo.toJson());

    return res;
  }
}
