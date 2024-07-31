import 'package:ifasoris/core/error/failure.dart';
import 'package:sqflite/sqflite.dart';

import '../../../services/connection_sqlite_service.dart';
import '../../models/cuidado_salud_cond_riesgo.dart';

abstract class CuidadoSaludCondRiesgoLocalDataSource {
  Future<int> saveCuidadoSaludCondRiesgo(
      CuidadoSaludCondRiesgoModel cuidadoSaludCondRiesgo);

  Future<CuidadoSaludCondRiesgoModel?> getCuidadoSaludCondRiesgo(
      int afiliadoId);
}

class CuidadoSaludCondRiesgoLocalDataSourceImpl
    implements CuidadoSaludCondRiesgoLocalDataSource {
  @override
  Future<int> saveCuidadoSaludCondRiesgo(
      CuidadoSaludCondRiesgoModel cuidadoSaludCondRiesgo) async {
    final db = await ConnectionSQLiteService.db;

    try {
      final res = await db.insert(
        'Asp5_CuidadoSaludCondRiesgo',
        cuidadoSaludCondRiesgo.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return res;
    } catch (e) {
      throw const DatabaseFailure(
          ['Error al guardar cuidado salud cond riesgo']);
    }
  }

  @override
  Future<CuidadoSaludCondRiesgoModel?> getCuidadoSaludCondRiesgo(
      int afiliadoId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp5_CuidadoSaludCondRiesgo',
        where: 'Afiliado_id = ?', whereArgs: [afiliadoId]);

    if (res.isEmpty) return null;

    final resultMap = {for (var e in res[0].entries) e.key: e.value};
    final result = CuidadoSaludCondRiesgoModel.fromJson(resultMap);
    return result;
  }
}
