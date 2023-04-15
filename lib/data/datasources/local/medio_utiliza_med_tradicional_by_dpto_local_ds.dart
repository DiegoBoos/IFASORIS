import '../../../domain/entities/medio_utiliza_med_tradicional_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/medio_utiliza_med_tradicional_model.dart';

abstract class MedioUtilizaMedTradicionalByDptoLocalDataSource {
  Future<List<MedioUtilizaMedTradicionalModel>>
      getMediosUtilizaMedTradicionalByDpto();
  Future<int> saveMedioUtilizaMedTradicionalByDpto(
      MedioUtilizaMedTradicionalEntity medioUtilizaMedTradicionalByDpto);
}

class MedioUtilizaMedTradicionalByDptoLocalDataSourceImpl
    implements MedioUtilizaMedTradicionalByDptoLocalDataSource {
  @override
  Future<List<MedioUtilizaMedTradicionalModel>>
      getMediosUtilizaMedTradicionalByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('MediosUtiliza_AccesoMedTradicional');
    final result = List<MedioUtilizaMedTradicionalModel>.from(
        res.map((m) => MedioUtilizaMedTradicionalModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveMedioUtilizaMedTradicionalByDpto(
      MedioUtilizaMedTradicionalEntity medioUtilizaMedTradicionalByDpto) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('MediosUtiliza_AccesoMedTradicional',
        medioUtilizaMedTradicionalByDpto.toJson());

    return res;
  }
}
