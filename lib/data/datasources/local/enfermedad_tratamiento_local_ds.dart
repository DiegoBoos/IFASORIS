import '../../../domain/entities/enfermedad_tratamiento_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/enfermedad_tratamiento_model.dart';

abstract class EnfermedadTratamientoLocalDataSource {
  Future<List<EnfermedadTratamientoModel>> getEnfermedadesTratamiento();
  Future<int> saveEnfermedadTratamiento(
      EnfermedadTratamientoEntity enfermedadTratamiento);
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
      EnfermedadTratamientoEntity enfermedadTratamiento) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('EnfermedadesTratamientos_AtencionSalud',
        enfermedadTratamiento.toJson());

    return res;
  }
}
