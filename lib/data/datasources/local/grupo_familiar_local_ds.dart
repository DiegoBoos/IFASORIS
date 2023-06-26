import 'package:ifasoris/core/error/failure.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/grupo_familiar_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/grupo_familiar_model.dart';

abstract class GrupoFamiliarLocalDataSource {
  Future<int> saveGrupoFamiliar(
      List<GrupoFamiliarEntity> afiliadosGrupoFamiliar);

  Future<List<GrupoFamiliarModel>> getGrupoFamiliar(int familiaId);
}

class GrupoFamiliarLocalDataSourceImpl implements GrupoFamiliarLocalDataSource {
  @override
  Future<int> saveGrupoFamiliar(
      List<GrupoFamiliarEntity> afiliadosGrupoFamiliar) async {
    final db = await ConnectionSQLiteService.db;

    try {
      final batch = db.batch();

      for (var afiliado in afiliadosGrupoFamiliar) {
        batch.insert(
          'Asp3_GrupoFamiliar',
          afiliado.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      final results = await batch.commit();
      return results.length;
    } catch (e) {
      throw const DatabaseFailure(['Error al guardar el grupo familiar']);
    }
  }

  @override
  Future<List<GrupoFamiliarModel>> getGrupoFamiliar(int familiaId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.rawQuery('''SELECT * FROM Asp3_GrupoFamiliar 
           JOIN Afiliado ON Asp3_GrupoFamiliar.Afiliado_id = Afiliado.Afiliado_id
           WHERE Asp3_GrupoFamiliar.Familia_id = $familiaId''');

    final result = List<GrupoFamiliarModel>.from(
        res.map((m) => GrupoFamiliarModel.fromJson(m))).toList();

    return result;
  }
}
