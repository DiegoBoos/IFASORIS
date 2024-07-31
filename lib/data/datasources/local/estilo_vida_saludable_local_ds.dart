import 'package:ifasoris/core/error/failure.dart';
import 'package:sqflite/sqflite.dart';

import '../../../services/connection_sqlite_service.dart';
import '../../models/estilo_vida_saludable.dart';

abstract class EstiloVidaSaludableLocalDataSource {
  Future<int> saveEstiloVidaSaludable(
      EstiloVidaSaludableModel estiloVidaSaludable);

  Future<EstiloVidaSaludableModel?> getEstiloVidaSaludable(int afiliadoId);
}

class EstiloVidaSaludableLocalDataSourceImpl
    implements EstiloVidaSaludableLocalDataSource {
  @override
  Future<int> saveEstiloVidaSaludable(
      EstiloVidaSaludableModel estiloVidaSaludable) async {
    final db = await ConnectionSQLiteService.db;

    try {
      final res = await db.insert(
        'Asp4_EstilosVidaSaludable',
        estiloVidaSaludable.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return res;
    } catch (e) {
      throw const DatabaseFailure(
          ['Error al guardar estilo de vida saludable']);
    }
  }

  @override
  Future<EstiloVidaSaludableModel?> getEstiloVidaSaludable(
      int afiliadoId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Asp4_EstilosVidaSaludable',
        where: 'Afiliado_id = ?', whereArgs: [afiliadoId]);

    if (res.isEmpty) return null;

    final resultMap = {for (var e in res[0].entries) e.key: e.value};
    final result = EstiloVidaSaludableModel.fromJson(resultMap);
    return result;
  }
}
