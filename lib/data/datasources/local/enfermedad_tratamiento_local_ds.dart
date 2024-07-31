import '../../../services/connection_sqlite_service.dart';
import '../../models/enfermedad_tratamiento.dart';

abstract class EnfermedadTratamientoLocalDataSource {
  Future<List<EnfermedadTratamientoModel>> getEnfermedadesTratamiento();
  Future<int> saveEnfermedadTratamiento(
      EnfermedadTratamientoModel enfermedadTratamiento);
}

class EnfermedadTratamientoLocalDataSourceImpl
    implements EnfermedadTratamientoLocalDataSource {
  @override
  Future<List<EnfermedadTratamientoModel>> getEnfermedadesTratamiento() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('EnfermedadesTratamientos_AtencionSalud');
    final result = List<EnfermedadTratamientoModel>.from(
        res.map((m) => EnfermedadTratamientoModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveEnfermedadTratamiento(
      EnfermedadTratamientoModel enfermedadTratamiento) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('EnfermedadesTratamientos_AtencionSalud',
        enfermedadTratamiento.toJson());

    return res;
  }
}
