import '../../../services/connection_sqlite_service.dart';
import '../../models/resguardo.dart';

abstract class ResguardoLocalDataSource {
  Future<List<ResguardoModel>> getResguardos();
  Future<int> saveResguardo(ResguardoModel resguardo);
}

class ResguardoLocalDataSourceImpl implements ResguardoLocalDataSource {
  @override
  Future<List<ResguardoModel>> getResguardos() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('Resguardos');
    final result =
        List<ResguardoModel>.from(res.map((m) => ResguardoModel.fromJson(m)))
            .toList();

    return result;
  }

  @override
  Future<int> saveResguardo(ResguardoModel resguardo) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('Resguardos', resguardo.toJson());

    return res;
  }
}
