import '../../../core/constants.dart';
import '../../models/nivel_educativo.dart';

abstract class NivelEducativoLocalDataSource {
  Future<List<NivelEducativoModel>> getNivelesEducativos();
  Future<int> saveNivelEducativo(NivelEducativoModel nivelEducativo);
}

class NivelEducativoLocalDataSourceImpl
    implements NivelEducativoLocalDataSource {
  @override
  Future<List<NivelEducativoModel>> getNivelesEducativos() async {
    final res = await supabase.from('NivelEducativo_GrupoFamiliar').select();
    final result = List<NivelEducativoModel>.from(
        res.map((m) => NivelEducativoModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveNivelEducativo(NivelEducativoModel nivelEducativo) async {
    final res = await supabase
        .from('NivelEducativo_GrupoFamiliar')
        .insert(nivelEducativo.toJson());

    return res;
  }
}
