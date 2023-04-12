import '../../../domain/entities/resguardo_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/resguardo_by_dpto_model.dart';

abstract class ResguardoByDptoLocalDataSource {
  Future<List<ResguardoModel>> getResguardosByDpto();
  Future<int> saveResguardoByDpto(ResguardoEntity resguardo);
}

class ResguardoByDptoLocalDataSourceImpl
    implements ResguardoByDptoLocalDataSource {
  @override
  Future<List<ResguardoModel>> getResguardosByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('ResguardoByDpto');
    final result =
        List<ResguardoModel>.from(res.map((m) => ResguardoModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveResguardoByDpto(ResguardoEntity resguardo) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('ResguardoByDpto', resguardo.toJson());

    return res;
  }
}
