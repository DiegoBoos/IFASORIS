import '../../../domain/entities/tiempo_tarda_med_tradicional_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/tiempo_tarda_med_tradicional_model.dart';

abstract class TiempoTardaMedTradicionalLocalDataSource {
  Future<List<TiempoTardaMedTradicionalModel>> getTiemposTardaMedTradicional();
  Future<int> saveTiempoTardaMedTradicional(
      TiempoTardaMedTradicionalEntity tiempoTardaMedTradicional);
}

class TiempoTardaMedTradicionalLocalDataSourceImpl
    implements TiempoTardaMedTradicionalLocalDataSource {
  @override
  Future<List<TiempoTardaMedTradicionalModel>>
      getTiemposTardaMedTradicional() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('TiemposTarda_AccesoMedTradicional');
    final result = List<TiempoTardaMedTradicionalModel>.from(
        res.map((m) => TiempoTardaMedTradicionalModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTiempoTardaMedTradicional(
      TiempoTardaMedTradicionalEntity tiempoTardaMedTradicional) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('TiemposTarda_AccesoMedTradicional',
        tiempoTardaMedTradicional.toJson());

    return res;
  }
}
