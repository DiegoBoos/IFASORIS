import '../../../domain/entities/especialidad_med_tradicional_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/especialidad_med_tradicional_model.dart';

abstract class EspecialidadMedTradicionalByDptoLocalDataSource {
  Future<List<EspecialidadMedTradicionalModel>>
      getEspecialidadesMedTradicionalByDpto();
  Future<int> saveEspecialidadMedTradicionalByDpto(
      EspecialidadMedTradicionalEntity especialidadMedTradicionalByDpto);
}

class EspecialidadMedTradicionalByDptoLocalDataSourceImpl
    implements EspecialidadMedTradicionalByDptoLocalDataSource {
  @override
  Future<List<EspecialidadMedTradicionalModel>>
      getEspecialidadesMedTradicionalByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('EspecialidadesMedTrad_AccesoMedTradicional');
    final result = List<EspecialidadMedTradicionalModel>.from(
        res.map((m) => EspecialidadMedTradicionalModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveEspecialidadMedTradicionalByDpto(
      EspecialidadMedTradicionalEntity especialidadMedTradicionalByDpto) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('EspecialidadesMedTrad_AccesoMedTradicional',
        especialidadMedTradicionalByDpto.toJson());

    return res;
  }
}
