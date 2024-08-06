import '../../../core/constants.dart';
import '../../models/grupo_riesgo.dart';

abstract class GrupoRiesgoLocalDataSource {
  Future<List<GrupoRiesgoModel>> getGruposRiesgo();
  Future<int> saveGrupoRiesgo(GrupoRiesgoModel grupoRiesgo);
}

class GrupoRiesgoLocalDataSourceImpl implements GrupoRiesgoLocalDataSource {
  @override
  Future<List<GrupoRiesgoModel>> getGruposRiesgo() async {
    final res = await supabase.from('GrupoRiesgo_GrupoFamiliar').select();
    final result = List<GrupoRiesgoModel>.from(
        res.map((m) => GrupoRiesgoModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveGrupoRiesgo(GrupoRiesgoModel grupoRiesgo) async {
    final res = await supabase
        .from('GrupoRiesgo_GrupoFamiliar')
        .insert(grupoRiesgo.toJson());

    return res;
  }
}
