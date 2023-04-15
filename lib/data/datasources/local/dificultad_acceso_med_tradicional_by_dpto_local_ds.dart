import '../../../domain/entities/dificultad_acceso_med_tradicional_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/dificultad_acceso_med_tradicional_model.dart';

abstract class DificultadAccesoMedTradicionalByDptoLocalDataSource {
  Future<List<DificultadAccesoMedTradicionalModel>>
      getDificultadesAccesoMedTradicionalByDpto();
  Future<int> saveDificultadAccesoMedTradicionalByDpto(
      DificultadAccesoMedTradicionalEntity
          dificultadAccesoMedTradicionalByDpto);
}

class DificultadAccesoMedTradicionalByDptoLocalDataSourceImpl
    implements DificultadAccesoMedTradicionalByDptoLocalDataSource {
  @override
  Future<List<DificultadAccesoMedTradicionalModel>>
      getDificultadesAccesoMedTradicionalByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('DificultadesAcceso_AccesoMedTradicional');
    final result = List<DificultadAccesoMedTradicionalModel>.from(
            res.map((m) => DificultadAccesoMedTradicionalModel.fromJson(m)))
        .toList();

    return result;
  }

  @override
  Future<int> saveDificultadAccesoMedTradicionalByDpto(
      DificultadAccesoMedTradicionalEntity
          dificultadAccesoMedTradicionalByDpto) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('DificultadesAcceso_AccesoMedTradicional',
        dificultadAccesoMedTradicionalByDpto.toJson());

    return res;
  }
}
