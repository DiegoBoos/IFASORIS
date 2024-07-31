import '../../../services/connection_sqlite_service.dart';
import '../../models/curso_vida.dart';

abstract class CursoVidaLocalDataSource {
  Future<List<CursoVidaModel>> getCursosVida();
  Future<int> saveCursoVida(CursoVidaModel cursoVida);
}

class CursoVidaLocalDataSourceImpl implements CursoVidaLocalDataSource {
  @override
  Future<List<CursoVidaModel>> getCursosVida() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('CursoVida_GrupoFamiliar');
    final result =
        List<CursoVidaModel>.from(res.map((m) => CursoVidaModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveCursoVida(CursoVidaModel cursoVida) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('CursoVida_GrupoFamiliar', cursoVida.toJson());

    return res;
  }
}
