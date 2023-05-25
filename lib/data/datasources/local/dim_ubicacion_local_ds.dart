import 'package:ifasoris/core/error/failure.dart';
import 'package:ifasoris/data/models/dim_ubicacion_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/dim_ubicacion_entity.dart';
import '../../../services/connection_sqlite_service.dart';

abstract class DimUbicacionLocalDataSource {
  Future<int> saveDimUbicacion(DimUbicacionEntity dimUbicacion);

  Future<DimUbicacionEntity?> getDimUbicacion(int familiaId);
}

class DimUbicacionLocalDataSourceImpl implements DimUbicacionLocalDataSource {
  @override
  Future<int> saveDimUbicacion(DimUbicacionEntity dimUbicacion) async {
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

  @override
  Future<DimUbicacionEntity?> getDimUbicacion(int familiaId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp1_Ubicacion',
        where: 'Familia_Id = ?', whereArgs: [familiaId]);

    if (res.isEmpty) return null;

    final resultMap = {for (var e in res[0].entries) e.key: e.value};
    final result = DimUbicacionModel.fromDB(resultMap);
    return result;
  }
}
