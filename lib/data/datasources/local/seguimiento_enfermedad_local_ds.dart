import '../../../services/connection_sqlite_service.dart';
import '../../models/seguimiento_enfermedad.dart';

abstract class SeguimientoEnfermedadLocalDataSource {
  Future<List<SeguimientoEnfermedadModel>> getSeguimientoEnfermedades();
  Future<int> saveSeguimientoEnfermedad(
      SeguimientoEnfermedadModel seguimientoEnfermedad);
}

class SeguimientoEnfermedadLocalDataSourceImpl
    implements SeguimientoEnfermedadLocalDataSource {
  @override
  Future<List<SeguimientoEnfermedadModel>> getSeguimientoEnfermedades() async {
    final db = await ConnectionSQLiteService.db;
    final res =
        await db.query('SeguimientoEnfermedades_CuidadoSaludCondRiesgo');
    final result = List<SeguimientoEnfermedadModel>.from(
        res.map((m) => SeguimientoEnfermedadModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveSeguimientoEnfermedad(
      SeguimientoEnfermedadModel seguimientoEnfermedad) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'SeguimientoEnfermedades_CuidadoSaludCondRiesgo',
        seguimientoEnfermedad.toJson());

    return res;
  }
}
