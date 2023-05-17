import 'package:ifasoris/core/error/failure.dart';
import 'package:ifasoris/data/models/dim_vivienda_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/dim_vivienda_entity.dart';
import '../../../services/connection_sqlite_service.dart';

abstract class DimViviendaLocalDataSource {
  Future<int> saveDimVivienda(DimViviendaEntity dimVivienda);

  Future<DimViviendaEntity?> getDimVivienda(int familiaId);
}

class DimViviendaLocalDataSourceImpl implements DimViviendaLocalDataSource {
  @override
  Future<int> saveDimVivienda(DimViviendaEntity dimVivienda) async {
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
  Future<DimViviendaEntity?> getDimVivienda(int familiaId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp2_DatosVivienda',
        where: 'Familia_Id = ?', whereArgs: [familiaId]);

    if (res.isEmpty) return null;

    final resultMap = {for (var e in res[0].entries) e.key: e.value};
    final result = DimViviendaModel.fromJson(resultMap);
    return result;
  }
}
