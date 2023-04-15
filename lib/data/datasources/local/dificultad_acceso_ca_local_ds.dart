import '../../../domain/entities/dificultad_acceso_ca_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/dificultad_acceso_ca_model.dart';

abstract class DificultadAccesoCALocalDataSource {
  Future<List<DificultadAccesoCAModel>> getDificultadesAccesoCA();
  Future<int> saveDificultadAccesoCA(
      DificultadAccesoCAEntity dificultadAccesoCA);
}

class DificultadAccesoCALocalDataSourceImpl
    implements DificultadAccesoCALocalDataSource {
  @override
  Future<List<DificultadAccesoCAModel>> getDificultadesAccesoCA() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('DificultadesAcceso_CentroAtencion');
    final result = List<DificultadAccesoCAModel>.from(
        res.map((m) => DificultadAccesoCAModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveDificultadAccesoCA(
      DificultadAccesoCAEntity dificultadAccesoCA) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'DificultadesAcceso_CentroAtencion', dificultadAccesoCA.toJson());

    return res;
  }
}
