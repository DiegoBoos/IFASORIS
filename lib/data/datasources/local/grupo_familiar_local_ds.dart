import 'package:ifasoris/core/error/failure.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/grupo_familiar_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/grupo_familiar_model.dart';

abstract class GrupoFamiliarLocalDataSource {
  Future<int> saveGrupoFamiliar(GrupoFamiliarEntity grupoFamiliar);

  Future<GrupoFamiliarEntity?> getGrupoFamiliar(int familiaId);
}

class GrupoFamiliarLocalDataSourceImpl implements GrupoFamiliarLocalDataSource {
  @override
  Future<int> saveGrupoFamiliar(GrupoFamiliarEntity grupoFamiliar) async {
    final db = await ConnectionSQLiteService.db;

    try {
      final res = await db.insert(
        'Asp2_DatosVivienda',
        grupoFamiliar.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return res;
    } catch (e) {
      throw const DatabaseFailure(['Error al guardar la vivienda']);
    }
  }

  @override
  Future<GrupoFamiliarEntity?> getGrupoFamiliar(int familiaId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp2_DatosVivienda',
        where: 'Familia_id = ?', whereArgs: [familiaId]);

    if (res.isEmpty) return null;

    final resultMap = {for (var e in res[0].entries) e.key: e.value};
    final result = GrupoFamiliarModel.fromJson(resultMap);
    return result;
  }
}
