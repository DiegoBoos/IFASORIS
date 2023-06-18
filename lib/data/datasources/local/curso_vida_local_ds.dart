import '../../../domain/entities/curso_vida_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/curso_vida_model.dart';

abstract class CursoVidaLocalDataSource {
  Future<List<CursoVidaModel>> getCursosVida();
  Future<int> saveCursoVida(CursoVidaEntity cursoVida);
}

class CursoVidaLocalDataSourceImpl implements CursoVidaLocalDataSource {
  @override
  Future<List<CursoVidaModel>> getCursosVida() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('CursosVida_CentroAtencion');
    final result =
        List<CursoVidaModel>.from(res.map((m) => CursoVidaModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveCursoVida(CursoVidaEntity cursoVida) async {
    final db = await ConnectionSQLiteService.db;

    final res =
        await db.insert('CursosVida_CentroAtencion', cursoVida.toJson());

    return res;
  }
}
