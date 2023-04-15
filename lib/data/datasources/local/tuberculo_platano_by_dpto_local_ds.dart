import '../../../domain/entities/tuberculo_platano_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/tuberculo_platano_model.dart';

abstract class TuberculoPlatanoByDptoLocalDataSource {
  Future<List<TuberculoPlatanoModel>> getTuberculosPlatanosByDpto();
  Future<int> saveTuberculoPlatanoByDpto(
      TuberculoPlatanoEntity tuberculoPlatano);
}

class TuberculoPlatanoByDptoLocalDataSourceImpl
    implements TuberculoPlatanoByDptoLocalDataSource {
  @override
  Future<List<TuberculoPlatanoModel>> getTuberculosPlatanosByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('TuberculosPlatanos_AspectosSocioEconomicos');
    final result = List<TuberculoPlatanoModel>.from(
        res.map((m) => TuberculoPlatanoModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTuberculoPlatanoByDpto(
      TuberculoPlatanoEntity tuberculoPlatano) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('TuberculosPlatanos_AspectosSocioEconomicos',
        tuberculoPlatano.toJson());

    return res;
  }
}
