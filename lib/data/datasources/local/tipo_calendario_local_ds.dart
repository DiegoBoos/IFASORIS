import '../../../services/connection_sqlite_service.dart';
import '../../models/tipo_calendario.dart';

abstract class TipoCalendarioLocalDataSource {
  Future<List<TipoCalendarioModel>> getTiposCalendario();
  Future<int> saveTipoCalendario(TipoCalendarioModel tipoCalendario);
}

class TipoCalendarioLocalDataSourceImpl
    implements TipoCalendarioLocalDataSource {
  @override
  Future<List<TipoCalendarioModel>> getTiposCalendario() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('TiposCalendarios_AspectosSocioEconomicos');
    final result = List<TipoCalendarioModel>.from(
        res.map((m) => TipoCalendarioModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTipoCalendario(TipoCalendarioModel tipoCalendario) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'TiposCalendarios_AspectosSocioEconomicos', tipoCalendario.toJson());

    return res;
  }
}
