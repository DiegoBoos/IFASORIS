import 'package:ifasoris/core/error/failure.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/dimension_sociocultural_pueblos_indigenas_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/dimension_sociocultural_pueblos_indigenas_model.dart';

abstract class DimensionSocioCulturalPueblosIndigenasLocalDataSource {
  Future<int> saveDimensionSocioCulturalPueblosIndigenas(
      DimensionSocioCulturalPueblosIndigenasEntity
          dimensionSocioCulturalPueblosIndigenas);

  Future<DimensionSocioCulturalPueblosIndigenasEntity?>
      getDimensionSocioCulturalPueblosIndigenas(int afiliadoId);
}

class DimensionSocioCulturalPueblosIndigenasLocalDataSourceImpl
    implements DimensionSocioCulturalPueblosIndigenasLocalDataSource {
  @override
  Future<int> saveDimensionSocioCulturalPueblosIndigenas(
      DimensionSocioCulturalPueblosIndigenasEntity
          dimensionSocioCulturalPueblosIndigenas) async {
    final db = await ConnectionSQLiteService.db;

    try {
      final res = await db.insert(
        'Asp6_DimSocioCulturalPueblosIndigenas',
        dimensionSocioCulturalPueblosIndigenas.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return res;
    } catch (e) {
      throw const DatabaseFailure(
          ['Error al guardar dim sociocultural pueblos indigenas']);
    }
  }

  @override
  Future<DimensionSocioCulturalPueblosIndigenasEntity?>
      getDimensionSocioCulturalPueblosIndigenas(int afiliadoId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp6_DimSocioCulturalPueblosIndigenas',
        where: 'Afiliado_id = ?', whereArgs: [afiliadoId]);

    if (res.isEmpty) return null;

    final resultMap = {for (var e in res[0].entries) e.key: e.value};
    final result =
        DimensionSocioCulturalPueblosIndigenasModel.fromJson(resultMap);
    return result;
  }
}
