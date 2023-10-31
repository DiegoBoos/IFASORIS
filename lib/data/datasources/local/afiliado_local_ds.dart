import 'package:ifasoris/data/models/afiliado_response_model.dart';
import 'package:ifasoris/domain/entities/familia_entity.dart';
import 'package:ifasoris/domain/usecases/ficha/ficha_exports.dart';

import '../../../services/connection_sqlite_service.dart';
import '../../models/familia_model.dart';
import '../../models/ficha_model.dart';

abstract class AfiliadoLocalDataSource {
  Future<List<AfiliadoModel>> getAfiliados(String query);
  Future<FichaEntity?> afiliadoTieneFicha(int afiliadoId);
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
  Future<FichaEntity?> afiliadoTieneFicha(int afiliadoId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.rawQuery('''
      SELECT Ficha.* , Familia.* FROM Familia 
      JOIN Ficha ON Ficha.Ficha_id = Familia.Ficha_id
      WHERE Familia.FK_Afiliado_id = $afiliadoId
      UNION ALL

      SELECT Ficha.*, Familia.* FROM Familia 
      JOIN Asp3_GrupoFamiliar ON Familia.Familia_id = Asp3_GrupoFamiliar.GrupoFamiliar_id
      JOIN Ficha ON Ficha.Ficha_id = Familia.Ficha_id
      WHERE Asp3_GrupoFamiliar.Afiliado_id  = $afiliadoId
      ''');

    if (res.isEmpty) return null;

    final resultMap = {for (var e in res[0].entries) e.key: e.value};
    final familia = FamiliaModel.fromJson(resultMap);
    resultMap['familia'] = familia.toJson();
    final result = FichaModel.fromJson(resultMap);

    return result;
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
