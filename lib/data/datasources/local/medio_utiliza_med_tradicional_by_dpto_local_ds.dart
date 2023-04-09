import '../../../domain/entities/medio_utiliza_med_tradicional_by_dpto_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/medio_utiliza_med_tradicional_by_dpto_model.dart';

abstract class MedioUtilizaMedTradicionalByDptoLocalDataSource {
  Future<List<MedioUtilizaMedTradicionalByDptoModel>>
      getMediosUtilizaMedTradicionalByDpto(int dtoId);
  Future<int> saveMedioUtilizaMedTradicionalByDpto(
      MedioUtilizaMedTradicionalByDptoEntity medioutilizaMedTradicionalByDpto);
}

class MedioUtilizaMedTradicionalByDptoLocalDataSourceImpl
    implements MedioUtilizaMedTradicionalByDptoLocalDataSource {
  @override
  Future<List<MedioUtilizaMedTradicionalByDptoModel>>
      getMediosUtilizaMedTradicionalByDpto(int dtoId) async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('MedioUtilizaMedTradicionalByDpto');
    final result = List<MedioUtilizaMedTradicionalByDptoModel>.from(
            res.map((m) => MedioUtilizaMedTradicionalByDptoModel.fromJson(m)))
        .toList();

    return result;
  }

  @override
  Future<int> saveMedioUtilizaMedTradicionalByDpto(
      MedioUtilizaMedTradicionalByDptoEntity
          medioUtilizaMedTradicionalByDpto) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('MedioUtilizaMedTradicionalByDpto',
        medioUtilizaMedTradicionalByDpto.toJson());

    return res;
  }
}
