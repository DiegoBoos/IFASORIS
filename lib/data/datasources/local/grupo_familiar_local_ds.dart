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

    /* try {
      return await db.transaction((txn) async {
        await txn.execute(
            'DELETE FROM Asp4_EstilosVidaSaludable WHERE Familia_id = ?',
            [familiaId]);

        //TODO: Asp5_CuidadoSaludCondRiesgo
        await txn.execute(
            'DELETE FROM Asp5_CuidadoSaludCondRiesgoNombresEnfermedad WHERE CuidadoSaludCondRiesgo_id = ?',
            []);
        await txn.execute(
            'DELETE FROM Asp5_CuidadoSaludCondRiesgoServiciosSolicita WHERE CuidadoSaludCondRiesgo_id = ?',
            []);
        await txn.execute(
            'DELETE FROM Asp5_CuidadoSaludCondRiesgo WHERE Familia_id = ?',
            [familiaId]);

        //TODO: Asp6_DimSocioCulturalPueblosIndigenas
        await txn.execute(
            'DELETE FROM Asp6_DimSocioCulturalEventosCostumbresParticipo WHERE DimSocioCulturalPueblosIndigenas_id = ?',
            []);
        await txn.execute(
            'DELETE FROM Asp6_DimSocioCulturalPueblosIndigenas WHERE Familia_id = ?',
            [familiaId]);

        //TODO: Asp7_AtencionSalud
        await txn.execute(
            'DELETE FROM Asp7_EnfermedadesTradicionales_AtencionSalud WHERE AtencionSalud_id = ?',
            []);
        await txn.execute(
            'DELETE FROM Asp7_EspecialidadesMedTradAtencionSalud WHERE AtencionSalud_id = ?',
            []);
        await txn.execute(
            'DELETE FROM Asp7_LugaresAtencionAtencionSalud WHERE AtencionSalud_id = ?',
            []);
        await txn.execute(
            'DELETE FROM Asp7_PlantasMedicinales_AtencionSalud WHERE AtencionSalud_id = ?',
            []);
        await txn.execute(
            'DELETE FROM Asp7_AtencionSalud WHERE Familia_id = ?', [familiaId]);

        final result = await db.delete('Asp3_GrupoFamiliar',
            where: 'Familia_id = ?', whereArgs: [familiaId]);

        return result;
      });
    } catch (e) {
      return 0;
    } */
  }

  @override
  Future<int> completeGrupoFamiliar(int familiaId) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.update('Asp3_GrupoFamiliar', {'isComplete': 1},
        where: 'Familia_id = ?', whereArgs: [familiaId]);

    return res;
  }
}
