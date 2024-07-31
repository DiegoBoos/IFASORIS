import 'package:ifasoris/core/error/failure.dart';

import 'package:sqflite/sqflite.dart';

import '../../../services/connection_sqlite_service.dart';
import '../../models/dim_ubicacion.dart';

abstract class DimUbicacionLocalDataSource {
  Future<int> saveDimUbicacion(DimUbicacionModel dimUbicacion);
  Future<DimUbicacionModel?> getDimUbicacion(int afiliadoId, int familiaId);
}

class DimUbicacionLocalDataSourceImpl implements DimUbicacionLocalDataSource {
  @override
  Future<DimUbicacionModel?> getDimUbicacion(
      int afiliadoId, int familiaId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp1_Ubicacion',
        where: 'Afiliado_id = ? AND Familia_id = ?',
        whereArgs: [afiliadoId, familiaId]);

    if (res.isEmpty) return null;

    final resultMap = {for (var e in res[0].entries) e.key: e.value};
    final result = DimUbicacionModel.fromJson(resultMap);
    return result;
  }

  @override
  Future<int> saveDimUbicacion(DimUbicacionModel dimUbicacion) async {
    final db = await ConnectionSQLiteService.db;

    try {
      final res = await db.insert(
        'Asp1_Ubicacion',
        dimUbicacion.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return res;
    } catch (e) {
      throw const DatabaseFailure(['Error al guardar la ubicación']);
    }
  }
}
