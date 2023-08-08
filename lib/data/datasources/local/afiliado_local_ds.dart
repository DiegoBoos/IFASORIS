import 'package:ifasoris/data/models/afiliado_response_model.dart';

import '../../../domain/entities/afiliado_entity.dart';
import '../../../services/connection_sqlite_service.dart';

abstract class AfiliadoLocalDataSource {
  Future<List<AfiliadoModel>> getAfiliados(String query);
  Future<AfiliadoModel?> afiliadoTieneFicha(int afiliadoId);
  Future<int> saveAfiliado(AfiliadoEntity afiliado);
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
  Future<AfiliadoModel?> afiliadoTieneFicha(int afiliadoId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.rawQuery('''SELECT * FROM Afiliado 
           JOIN Familia ON Afiliado.Afiliado_id = Familia.Afiliado_id 
           JOIN Ficha ON Ficha.Ficha_id = Familia.Ficha_id
           WHERE Afiliado.Afiliado_id = $afiliadoId''');

    if (res.isEmpty) return null;

    final resultMap = {for (var e in res[0].entries) e.key: e.value};
    final result = AfiliadoModel.fromJson(resultMap);
    return result;
  }

  @override
  Future<int> saveAfiliado(AfiliadoEntity afiliado) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('Afiliado', afiliado.toJson());

    return res;
  }
}
