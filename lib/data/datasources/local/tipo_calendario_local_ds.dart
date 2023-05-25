import '../../../domain/entities/tipo_calendario_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/tipo_calendario_model.dart';

abstract class TipoCalendarioLocalDataSource {
  Future<List<TipoCalendarioModel>> getTiposCalendario();
  Future<int> saveTipoCalendario(TipoCalendarioEntity tipoCalendario);
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
  Future<int> saveTipoCalendario(TipoCalendarioEntity tipoCalendario) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'TiposCalendarios_AspectosSocioEconomicos', tipoCalendario.toJson());

    return res;
  }
}
