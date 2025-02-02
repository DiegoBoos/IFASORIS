import '../../../core/error/failure.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/grupo_familiar.dart';

abstract class GrupoFamiliarLocalDataSource {
  Future<GrupoFamiliarModel> saveGrupoFamiliar(
      GrupoFamiliarModel afiliadoGrupoFamiliar);

  Future<List<GrupoFamiliarModel>> getGrupoFamiliar(int familiaId);

  Future<int> deleteAfiliadoGrupoFamiliar(int afiliadoId, int familiaId);

  Future<int> completeGrupoFamiliar(int afiliadoId);

  Future<bool> existeAfiliadoCabezaFamilia(int afiliadoId);
}

class GrupoFamiliarLocalDataSourceImpl implements GrupoFamiliarLocalDataSource {
  @override
  Future<GrupoFamiliarModel> saveGrupoFamiliar(
      GrupoFamiliarModel afiliadoGrupoFamiliar) async {
    try {
      final db = await ConnectionSQLiteService.db;

      if (afiliadoGrupoFamiliar.grupoFamiliarId == null) {
        await db.insert(
          'Asp3_GrupoFamiliar',
          afiliadoGrupoFamiliar.toJson(),
        );
      } else {
        await db.update(
          'Asp3_GrupoFamiliar',
          afiliadoGrupoFamiliar.toJson(),
          where: 'Afiliado_id = ?',
          whereArgs: [
            afiliadoGrupoFamiliar.afiliadoId,
          ],
        );
      }

      final consultarAfiliado =
          await db.rawQuery('''SELECT Afiliado.nombre1, Afiliado.nombre2,
              Afiliado.apellido1, Afiliado.apellido2, Asp3_GrupoFamiliar.* FROM Asp3_GrupoFamiliar
              LEFT JOIN Afiliado ON Asp3_GrupoFamiliar.Afiliado_id = Afiliado.Afiliado_id
              WHERE Asp3_GrupoFamiliar.Afiliado_id = ${afiliadoGrupoFamiliar.afiliadoId}
              AND Asp3_GrupoFamiliar.Familia_id = ${afiliadoGrupoFamiliar.familiaId}''');

      if (consultarAfiliado.isNotEmpty) {
        return GrupoFamiliarModel.fromJson(consultarAfiliado.first);
      } else {
        throw const DatabaseFailure(['Registro no encontrado']);
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
  Future<int> completeGrupoFamiliar(int afiliado) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.update('Asp3_GrupoFamiliar', {'isComplete': 1},
        where: 'Afiliado_id = ?', whereArgs: [afiliado]);

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
