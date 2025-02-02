import '../../../services/connection_sqlite_service.dart';
import '../../models/nivel_educativo.dart';

abstract class NivelEducativoLocalDataSource {
  Future<List<NivelEducativoModel>> getNivelesEducativos();
  Future<int> saveNivelEducativo(NivelEducativoModel nivelEducativo);
}

class NivelEducativoLocalDataSourceImpl
    implements NivelEducativoLocalDataSource {
  @override
  Future<List<NivelEducativoModel>> getNivelesEducativos() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('NivelEducativo_GrupoFamiliar');
    final result = List<NivelEducativoModel>.from(
        res.map((m) => NivelEducativoModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveNivelEducativo(NivelEducativoModel nivelEducativo) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'NivelEducativo_GrupoFamiliar', nivelEducativo.toJson());

    return res;
  }
}
