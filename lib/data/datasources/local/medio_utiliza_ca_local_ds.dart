import '../../../domain/entities/medio_utiliza_ca_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/medio_utiliza_ca_model.dart';

abstract class MedioUtilizaCALocalDataSource {
  Future<List<MedioUtilizaCAModel>> getMediosUtilizaCA();
  Future<int> saveMedioUtilizaCA(MedioUtilizaCAEntity medioUtilizaCA);
}

class MedioUtilizaCALocalDataSourceImpl
    implements MedioUtilizaCALocalDataSource {
  @override
  Future<List<MedioUtilizaCAModel>> getMediosUtilizaCA() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('MedioUtilizaCA');
    final mediosUtilizaCADB = List<MedioUtilizaCAModel>.from(
        res.map((m) => MedioUtilizaCAModel.fromJson(m))).toList();

    return mediosUtilizaCADB;
  }

  @override
  Future<int> saveMedioUtilizaCA(MedioUtilizaCAEntity medioUtilizaCA) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('MedioUtilizaCA', medioUtilizaCA.toJson());

    return res;
  }
}
