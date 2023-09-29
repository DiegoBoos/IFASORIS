import 'package:ifasoris/core/error/failure.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/grupo_familiar_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/grupo_familiar_model.dart';

abstract class GrupoFamiliarLocalDataSource {
  Future<int> saveGrupoFamiliar(
      List<GrupoFamiliarEntity> afiliadosGrupoFamiliar);

  Future<List<GrupoFamiliarModel>> getGrupoFamiliar(int familiaId);

  Future<int> deleteAfiliadoGrupoFamiliar(int afiliadoId);

  Future<int> existeAfiliadoGrupoFamiliar(int afiliadoId);
}

class GrupoFamiliarLocalDataSourceImpl implements GrupoFamiliarLocalDataSource {
  @override
  Future<int> saveGrupoFamiliar(
      List<GrupoFamiliarEntity> afiliadosGrupoFamiliar) async {
    final db = await ConnectionSQLiteService.db;
    final batch = db.batch();

    for (var afiliado in afiliadosGrupoFamiliar) {
      final existingRecords = await db.rawQuery('''
      SELECT COUNT(*) FROM Asp3_GrupoFamiliar WHERE Afiliado_id = ?
    ''', [afiliado.afiliadoId]);

      final recordCount = Sqflite.firstIntValue(existingRecords);
      if (recordCount == 0) {
        batch.insert(
          'Asp3_GrupoFamiliar',
          afiliado.toJson(),
        );
      } else {
        batch.update(
          'Asp3_GrupoFamiliar',
          afiliado.toJson(),
          where: 'Afiliado_id = ?',
          whereArgs: [afiliado.afiliadoId],
        );
      }
    }

    try {
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

  @override
  Future<int> deleteAfiliadoGrupoFamiliar(int afiliadoId) async {
    final db = await ConnectionSQLiteService.db;

    final result = await db.delete('Asp3_GrupoFamiliar',
        where: 'Afiliado_id = ?', whereArgs: [afiliadoId]);

    return result;
  }

  @override
  Future<int> existeAfiliadoGrupoFamiliar(int afiliadoId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.rawQuery('''SELECT Afiliado_id FROM Asp3_GrupoFamiliar 
           WHERE Asp3_GrupoFamiliar.Afiliado_id = $afiliadoId''');

    if (res.isEmpty) return 0;

    final existeAfiliadoId = res[0].entries.first.value as int;
    return existeAfiliadoId;
  }
}
