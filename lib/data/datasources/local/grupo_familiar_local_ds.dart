import 'package:ifasoris/core/error/failure.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/grupo_familiar_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/grupo_familiar_model.dart';

abstract class GrupoFamiliarLocalDataSource {
  Future<int> saveGrupoFamiliar(
      List<GrupoFamiliarEntity> afiliadosGrupoFamiliar);

  Future<List<GrupoFamiliarModel>> getGrupoFamiliar(int familiaId);

  Future<int> deleteAfiliadosGrupoFamiliar(int familiaId);
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
  Future<int> deleteAfiliadosGrupoFamiliar(int familiaId) async {
    final db = await ConnectionSQLiteService.db;

    try {
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
    }
  }
}
