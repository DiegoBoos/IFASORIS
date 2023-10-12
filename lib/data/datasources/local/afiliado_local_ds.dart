import 'package:ifasoris/data/models/afiliado_response_model.dart';

import '../../../services/connection_sqlite_service.dart';

abstract class AfiliadoLocalDataSource {
  Future<List<AfiliadoModel>> getAfiliados(String query);
  Future<int> afiliadoTieneFicha(int afiliadoId);
  Future<String> afiliadoTieneFichaReportada(int afiliadoId);
}

class AfiliadoLocalDataSourceImpl implements AfiliadoLocalDataSource {
  @override
  Future<List<AfiliadoModel>> getAfiliados(String query) async {
    final db = await ConnectionSQLiteService.db;
    final res =
        await db.query('Afiliado', where: 'documento = ?', whereArgs: [query]);
    final result =
        List<AfiliadoModel>.from(res.map((m) => AfiliadoModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> afiliadoTieneFicha(int afiliadoId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.rawQuery('''
      SELECT Ficha.Ficha_id FROM Familia 
      JOIN Ficha ON Ficha.Ficha_id = Familia.Ficha_id
      WHERE Familia.FK_Afiliado_id = $afiliadoId
      UNION ALL
      SELECT Ficha.Ficha_id FROM Familia 
      JOIN Asp3_GrupoFamiliar ON Familia.Familia_id = Asp3_GrupoFamiliar.GrupoFamiliar_id
      JOIN Ficha ON Ficha.Ficha_id = Familia.Ficha_id
      WHERE Asp3_GrupoFamiliar.Afiliado_id  = $afiliadoId
      ''');

    if (res.isEmpty) return 0;

    final fichaId = res[0].entries.first.value as int;
    return fichaId;
  }

  @override
  Future<String> afiliadoTieneFichaReportada(int afiliadoId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.rawQuery('''
      SELECT Ficha.NumFicha FROM Familia 
      JOIN Ficha ON Ficha.Ficha_id = Familia.Ficha_id
      WHERE Familia.FK_Afiliado_id = $afiliadoId AND Ficha.NumFicha <> ''
      UNION ALL
      SELECT Ficha.NumFicha FROM Familia 
      JOIN Asp3_GrupoFamiliar ON Familia.Familia_id = Asp3_GrupoFamiliar.GrupoFamiliar_id
      JOIN Ficha ON Ficha.Ficha_id = Familia.Ficha_id
      WHERE Asp3_GrupoFamiliar.Afiliado_id  = $afiliadoId AND Ficha.NumFicha <> ''
           ''');
    if (res.isEmpty) return '';

    final numFicha = res[0].entries.first.value as String;
    return numFicha;
  }
}
