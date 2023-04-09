import '../../../domain/entities/especialidad_med_tradicional_by_dpto_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/especialidad_med_tradicional_by_dpto_model.dart';

abstract class EspecialidadMedTradicionalByDptoLocalDataSource {
  Future<List<EspecialidadMedTradicionalByDptoModel>>
      getEspecialidadesMedTradicionalByDpto(int dtoId);
  Future<int> saveEspecialidadMedTradicionalByDpto(
      EspecialidadMedTradicionalByDptoEntity especialidadMedTradicionalByDpto);
}

class EspecialidadMedTradicionalByDptoLocalDataSourceImpl
    implements EspecialidadMedTradicionalByDptoLocalDataSource {
  @override
  Future<List<EspecialidadMedTradicionalByDptoModel>>
      getEspecialidadesMedTradicionalByDpto(int dtoId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('EspecialidadMedTradicionalByDpto');
    final result = List<EspecialidadMedTradicionalByDptoModel>.from(
            res.map((m) => EspecialidadMedTradicionalByDptoModel.fromJson(m)))
        .toList();

    return result;
  }

  @override
  Future<int> saveEspecialidadMedTradicionalByDpto(
      EspecialidadMedTradicionalByDptoEntity
          especialidadMedTradicionalByDpto) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('EspecialidadMedTradicionalByDpto',
        especialidadMedTradicionalByDpto.toJson());

    return res;
  }
}
