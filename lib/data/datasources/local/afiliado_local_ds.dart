import 'package:ifasoris/data/models/afiliado_response_model.dart';

import '../../../domain/entities/afiliado_entity.dart';
import '../../../services/connection_sqlite_service.dart';

abstract class AfiliadoLocalDataSource {
  Future<List<AfiliadoModel>> getAfiliados(
      int dtoId, int pagina, int registrosPorPagina);
  Future<int> saveAfiliado(AfiliadoEntity afiliado);
}

class AfiliadoLocalDataSourceImpl implements AfiliadoLocalDataSource {
  @override
  Future<List<AfiliadoModel>> getAfiliados(
      int dtoId, int pagina, int registrosPorPagina) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Afiliado');
    final result =
        List<AfiliadoModel>.from(res.map((m) => AfiliadoModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveAfiliado(AfiliadoEntity afiliado) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('Afiliado', afiliado.toJson());

    return res;
  }
}
