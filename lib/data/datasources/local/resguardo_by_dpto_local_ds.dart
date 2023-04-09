import '../../../domain/entities/resguardo_by_dpto_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/resguardo_by_dpto_model.dart';

abstract class ResguardoByDptoLocalDataSource {
  Future<List<ResguardoByDptoModel>> getResguardosByDpto(int dtoId);
  Future<int> saveResguardoByDpto(ResguardoByDptoEntity resguardobydpto);
}

class ResguardoByDptoLocalDataSourceImpl
    implements ResguardoByDptoLocalDataSource {
  @override
  Future<List<ResguardoByDptoModel>> getResguardosByDpto(int dtoId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('ResguardoByDpto');
    final resguardosbydptoDB = List<ResguardoByDptoModel>.from(
        res.map((m) => ResguardoByDptoModel.fromJson(m))).toList();

    return resguardosbydptoDB;
  }

  @override
  Future<int> saveResguardoByDpto(ResguardoByDptoEntity resguardoByDpto) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('ResguardoByDpto', resguardoByDpto.toJson());

    return res;
  }
}
