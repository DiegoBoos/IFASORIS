import 'package:ifasoris/core/error/failure.dart';
import 'package:sqflite/sqflite.dart';

import '../../../services/connection_sqlite_service.dart';
import '../../models/dim_vivienda.dart';

abstract class DimViviendaLocalDataSource {
  Future<int> saveDimVivienda(DimViviendaModel dimVivienda);

  Future<DimViviendaModel?> getDimVivienda(int afiliadoId, int familiaId);
}

class DimViviendaLocalDataSourceImpl implements DimViviendaLocalDataSource {
  @override
  Future<int> saveDimVivienda(DimViviendaModel dimVivienda) async {
    final db = await ConnectionSQLiteService.db;

    try {
      final res = await db.insert(
        'Asp2_DatosVivienda',
        dimVivienda.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return res;
    } catch (e) {
      throw const DatabaseFailure(['Error al guardar la vivienda']);
    }
  }

  @override
  Future<DimViviendaModel?> getDimVivienda(
      int afiliadoId, int familiaId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp2_DatosVivienda',
        where: 'Afiliado_id = ? AND Familia_id = ?',
        whereArgs: [afiliadoId, familiaId]);

    if (res.isEmpty) return null;

    final resultMap = {for (var e in res[0].entries) e.key: e.value};
    final result = DimViviendaModel.fromJson(resultMap);
    return result;
  }
}
