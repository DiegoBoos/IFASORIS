import '../../../domain/entities/nivel_educativo_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/nivel_educativo_model.dart';

abstract class NivelEducativoLocalDataSource {
  Future<List<NivelEducativoModel>> getNivelesEducativos();
  Future<int> saveNivelEducativo(NivelEducativoEntity nivelEducativo);
}

class NivelEducativoLocalDataSourceImpl
    implements NivelEducativoLocalDataSource {
  @override
  Future<List<NivelEducativoModel>> getNivelesEducativos() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('NivelesEducativos_CentroAtencion');
    final result = List<NivelEducativoModel>.from(
        res.map((m) => NivelEducativoModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveNivelEducativo(NivelEducativoEntity nivelEducativo) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'NivelesEducativos_CentroAtencion', nivelEducativo.toJson());

    return res;
  }
}
