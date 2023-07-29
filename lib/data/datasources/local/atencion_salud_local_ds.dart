import 'package:ifasoris/core/error/failure.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/atencion_salud_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/atencion_salud_model.dart';

abstract class AtencionSaludLocalDataSource {
  Future<int> saveAtencionSalud(AtencionSaludEntity atencionSalud);

  Future<AtencionSaludEntity?> getAtencionSalud(int afiliadoId);
}

class AtencionSaludLocalDataSourceImpl implements AtencionSaludLocalDataSource {
  @override
  Future<int> saveAtencionSalud(AtencionSaludEntity atencionSalud) async {
    final db = await ConnectionSQLiteService.db;

    try {
      final res = await db.insert(
        'Asp5_AtencionSalud',
        atencionSalud.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return res;
    } catch (e) {
      throw const DatabaseFailure(
          ['Error al guardar estilo de vida saludable']);
    }
  }

  @override
  Future<AtencionSaludEntity?> getAtencionSalud(int afiliadoId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp5_AtencionSalud',
        where: 'Afiliado_id = ?', whereArgs: [afiliadoId]);

    if (res.isEmpty) return null;

    final resultMap = {for (var e in res[0].entries) e.key: e.value};
    final result = AtencionSaludModel.fromJson(resultMap);
    return result;
  }
}
