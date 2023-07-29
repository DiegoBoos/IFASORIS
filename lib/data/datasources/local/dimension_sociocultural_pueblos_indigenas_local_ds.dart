import 'package:ifasoris/core/error/failure.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/dimension_sociocultural_pueblos_indigenas_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/dimension_sociocultural_pueblos_indigenas_model.dart';

abstract class DimensionSocioculturalPueblosIndigenasLocalDataSource {
  Future<int> saveDimensionSocioculturalPueblosIndigenas(
      DimensionSocioculturalPueblosIndigenasEntity
          dimensionSocioculturalPueblosIndigenas);

  Future<DimensionSocioculturalPueblosIndigenasEntity?>
      getDimensionSocioculturalPueblosIndigenas(int afiliadoId);
}

class DimensionSocioculturalPueblosIndigenasLocalDataSourceImpl
    implements DimensionSocioculturalPueblosIndigenasLocalDataSource {
  @override
  Future<int> saveDimensionSocioculturalPueblosIndigenas(
      DimensionSocioculturalPueblosIndigenasEntity
          dimensionSocioculturalPueblosIndigenas) async {
    final db = await ConnectionSQLiteService.db;

    try {
      final res = await db.insert(
        'Asp5_DimensionSocioculturalPueblosIndigenas',
        dimensionSocioculturalPueblosIndigenas.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return res;
    } catch (e) {
      throw const DatabaseFailure(
          ['Error al guardar estilo de vida saludable']);
    }
  }

  @override
  Future<DimensionSocioculturalPueblosIndigenasEntity?>
      getDimensionSocioculturalPueblosIndigenas(int afiliadoId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp5_DimensionSocioculturalPueblosIndigenas',
        where: 'Afiliado_id = ?', whereArgs: [afiliadoId]);

    if (res.isEmpty) return null;

    final resultMap = {for (var e in res[0].entries) e.key: e.value};
    final result =
        DimensionSocioculturalPueblosIndigenasModel.fromJson(resultMap);
    return result;
  }
}
