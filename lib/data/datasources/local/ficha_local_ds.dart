import 'package:ifasoris/data/models/ficha_model.dart';

import '../../../domain/entities/ficha_entity.dart';
import '../../../services/connection_sqlite_service.dart';

abstract class FichaLocalDataSource {
  Future<FichaEntity> createFicha(FichaEntity ficha);
  Future<List<FichaModel>> loadFichas();

  Future<int> deleteFicha(int fichaId);
}

class FichaLocalDataSourceImpl implements FichaLocalDataSource {
  @override
  Future<FichaEntity> createFicha(FichaEntity ficha) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('Ficha', ficha.toJsonLocal());

    ficha.fichaId = res;

    return ficha;
  }

  @override
  Future<List<FichaModel>> loadFichas() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Ficha');
    final result =
        List<FichaModel>.from(res.map((m) => FichaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> deleteFicha(int fichaId) async {
    final db = await ConnectionSQLiteService.db;

    final res =
        await db.delete('Ficha', where: 'Ficha_id = ?', whereArgs: [fichaId]);

    return res;
  }
}
