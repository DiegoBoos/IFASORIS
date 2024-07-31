import '../../../services/connection_sqlite_service.dart';
import '../../models/autoridad_indigena.dart';

abstract class AutoridadIndigenaLocalDataSource {
  Future<List<AutoridadIndigenaModel>> getAutoridadesIndigenas();
  Future<int> saveAutoridadIndigena(AutoridadIndigenaModel autoridadIndigena);
}

class AutoridadIndigenaLocalDataSourceImpl
    implements AutoridadIndigenaLocalDataSource {
  @override
  Future<List<AutoridadIndigenaModel>> getAutoridadesIndigenas() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('AutoridadesIndigenas_DatosVivienda');
    final result = List<AutoridadIndigenaModel>.from(
        res.map((m) => AutoridadIndigenaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveAutoridadIndigena(
      AutoridadIndigenaModel autoridadIndigena) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'AutoridadesIndigenas_DatosVivienda', autoridadIndigena.toJson());

    return res;
  }
}
