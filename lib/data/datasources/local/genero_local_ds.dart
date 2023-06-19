import '../../../domain/entities/genero_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/genero_model.dart';

abstract class GeneroLocalDataSource {
  Future<List<GeneroModel>> getGeneros();
  Future<int> saveGenero(GeneroEntity genero);
}

class GeneroLocalDataSourceImpl implements GeneroLocalDataSource {
  @override
  Future<List<GeneroModel>> getGeneros() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Genero_GrupoFamiliar');
    final result =
        List<GeneroModel>.from(res.map((m) => GeneroModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveGenero(GeneroEntity genero) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('Genero_GrupoFamiliar', genero.toJson());

    return res;
  }
}
