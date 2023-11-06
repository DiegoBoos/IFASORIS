import 'package:sqflite/sqflite.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/grupo_familiar_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/grupo_familiar_model.dart';

abstract class GrupoFamiliarLocalDataSource {
  Future<Map<String, dynamic>> saveGrupoFamiliar(
      GrupoFamiliarEntity afiliadoGrupoFamiliar);

  Future<List<GrupoFamiliarModel>> getGrupoFamiliar(int familiaId);

  Future<int> deleteAfiliadoGrupoFamiliar(int afiliadoId, int familiaId);

  Future<int> completeGrupoFamiliar(int familiaId);

  Future<bool> existeAfiliadoCabezaFamilia(int afiliadoId);
}

class GrupoFamiliarLocalDataSourceImpl implements GrupoFamiliarLocalDataSource {
  @override
  Future<Map<String, dynamic>> saveGrupoFamiliar(
      GrupoFamiliarEntity afiliadoGrupoFamiliar) async {
    try {
      final db = await ConnectionSQLiteService.db;
      final resUpdate = await db.update(
        'Asp3_GrupoFamiliar',
        afiliadoGrupoFamiliar.toJson(),
        where: 'Afiliado_id = ? AND Familia_id = ?',
        whereArgs: [
          afiliadoGrupoFamiliar.afiliadoId,
          afiliadoGrupoFamiliar.familiaId
        ],
      );
      if (resUpdate > 0) {
        return {'res': resUpdate, 'existeRegistro': true};
      } else {
        final resInsert = await db.insert(
          'Asp3_GrupoFamiliar',
          afiliadoGrupoFamiliar.toJson(),
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
        return {'res': resInsert, 'existeRegistro': false};
      }
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

  @override
  Future<int> deleteAfiliadoGrupoFamiliar(int afiliadoId, int familiaId) async {
    final db = await ConnectionSQLiteService.db;

    final result = await db.delete('Asp3_GrupoFamiliar',
        where: 'Afiliado_id = ? AND Familia_id = ?',
        whereArgs: [afiliadoId, familiaId]);

    return result;
  }

  @override
  Future<int> completeGrupoFamiliar(int familiaId) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.update('Asp3_GrupoFamiliar', {'isComplete': 1},
        where: 'Familia_id = ?', whereArgs: [familiaId]);

    return res;
  }

  @override
  Future<bool> existeAfiliadoCabezaFamilia(int afiliadoId) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.rawQuery('''
    SELECT EXISTS (
      SELECT 1 FROM Asp3_GrupoFamiliar 
      INNER JOIN Familia ON Asp3_GrupoFamiliar.Afiliado_id = Familia.FK_Afiliado_id
      WHERE Asp3_GrupoFamiliar.Afiliado_id = ?
    )
  ''', [afiliadoId]);

    if (res.isEmpty) return false;

    final result = res.first.values.first as int;

    return result == 1;
  }
}
