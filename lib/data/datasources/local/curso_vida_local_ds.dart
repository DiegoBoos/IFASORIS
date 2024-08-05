import '../../../core/constants.dart';
import '../../models/curso_vida.dart';

abstract class CursoVidaLocalDataSource {
  Future<List<CursoVidaModel>> getCursosVida();
  Future<int> saveCursoVida(CursoVidaModel cursoVida);
}

class CursoVidaLocalDataSourceImpl implements CursoVidaLocalDataSource {
  @override
  Future<List<CursoVidaModel>> getCursosVida() async {
    final res = await supabase.from('CursoVida_GrupoFamiliar').select();
    final result =
        List<CursoVidaModel>.from(res.map((m) => CursoVidaModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveCursoVida(CursoVidaModel cursoVida) async {
    final res = await supabase
        .from('CursoVida_GrupoFamiliar')
        .insert(cursoVida.toJson());

    return res;
  }
}
