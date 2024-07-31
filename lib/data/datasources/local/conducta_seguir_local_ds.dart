import '../../../services/connection_sqlite_service.dart';
import '../../models/conducta_seguir.dart';

abstract class ConductaSeguirLocalDataSource {
  Future<List<ConductaSeguirModel>> getConductasSeguir();
  Future<int> saveConductaSeguir(ConductaSeguirModel conductaSeguir);
}

class ConductaSeguirLocalDataSourceImpl
    implements ConductaSeguirLocalDataSource {
  @override
  Future<List<ConductaSeguirModel>> getConductasSeguir() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('ConductasSeguir_CuidadoSaludCondRiesgo');
    final result = List<ConductaSeguirModel>.from(
        res.map((m) => ConductaSeguirModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveConductaSeguir(ConductaSeguirModel conductaSeguir) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'ConductasSeguir_CuidadoSaludCondRiesgo', conductaSeguir.toJson());

    return res;
  }
}
