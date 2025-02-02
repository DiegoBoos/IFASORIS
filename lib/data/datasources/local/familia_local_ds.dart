import '../../../services/connection_sqlite_service.dart';
import '../../models/familia.dart';

abstract class FamiliaLocalDataSource {
  Future<FamiliaModel?> createFamilia(FamiliaModel familia);
  Future<List<FamiliaModel>> loadFamilias();

  Future<int> deleteAfiliadoFamilia(int fkAfiliadoId);
}

class FamiliaLocalDataSourceImpl implements FamiliaLocalDataSource {
  @override
  Future<FamiliaModel?> createFamilia(FamiliaModel familia) async {
    final db = await ConnectionSQLiteService.db;

    // final res = await db.insert('Familia', familia.toJson());

    // // Esta instruccion acuaualiza los datos de familia para el caso cuando se crea una nueva ficha de un afiliados que pertenence a un grupo familiar
    // final sql = '''
    // DELETE FROM Asp3_GrupoFamiliar where Afiliado_id = $familia.fkAfiliadoId;
    // UPDATE Asp4_EstilosVidaSaludable SET Familia_id = $familia.familiaId AND Afiliado_id = $familia.fkAfiliadoId;
    // UPDATE Asp5_CuidadoSaludCondRiesgo SET Familia_id = $familia.familiaId AND Afiliado_id = $familia.fkAfiliadoId;
    // UPDATE Asp6_DimSocioCulturalPueblosIndigenas SET Familia_id = $familia.familiaId AND Afiliado_id = $familia.fkAfiliadoId;
    // UPDATE Asp7_AtencionSalud SET Familia_id = $familia.familiaId AND Afiliado_id = $familia.fkAfiliadoId;
    // ''';
    // await db.execute(sql);

    // familia.familiaId = res;
    // Iniciar una transacción
    return await db.transaction((txn) async {
      // Insertar la nueva familia en la tabla 'Familia'
      final res = await txn.insert('Familia', familia.toJson());
      // Actualizar el ID de familia
      final newFamilia = familia.copyWith(familiaId: res);

      // Eliminar filas en la tabla 'Asp3_GrupoFamiliar'
      await txn.execute('DELETE FROM Asp3_GrupoFamiliar WHERE Afiliado_id = ?',
          [newFamilia.fkAfiliadoId]);

      // Actualizar otras tablas una por una
      await txn.execute(
          'UPDATE Asp4_EstilosVidaSaludable SET Familia_id = ? WHERE Afiliado_id = ?',
          [newFamilia.familiaId, newFamilia.fkAfiliadoId]);
      await txn.execute(
          'UPDATE Asp5_CuidadoSaludCondRiesgo SET Familia_id = ? WHERE Afiliado_id = ?',
          [newFamilia.familiaId, newFamilia.fkAfiliadoId]);
      await txn.execute(
          'UPDATE Asp6_DimSocioCulturalPueblosIndigenas SET Familia_id = ? WHERE Afiliado_id = ?',
          [newFamilia.familiaId, newFamilia.fkAfiliadoId]);
      await txn.execute(
          'UPDATE Asp7_AtencionSalud SET Familia_id = ? WHERE Afiliado_id = ?',
          [newFamilia.familiaId, newFamilia.fkAfiliadoId]);

      return newFamilia;
    });
  }

  @override
  Future<List<FamiliaModel>> loadFamilias() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Familia');
    final result =
        List<FamiliaModel>.from(res.map((m) => FamiliaModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> deleteAfiliadoFamilia(int fkAfiliadoId) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.delete('Familia',
        where: 'FK_Afiliado_id = ?', whereArgs: [fkAfiliadoId]);

    return res;
  }
}
