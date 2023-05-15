import '../../../domain/entities/tipo_sanitario_vivienda_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/tipo_sanitario_vivienda_model.dart';

abstract class TipoSanitarioViviendaByDptoLocalDataSource {
  Future<List<TipoSanitarioViviendaModel>> getTiposSanitarioViviendaByDpto();
  Future<int> saveTipoSanitarioViviendaByDpto(
      TipoSanitarioViviendaEntity tipoSanitarioViviendaByDpto);
}

class TipoSanitarioViviendaByDptoLocalDataSourceImpl
    implements TipoSanitarioViviendaByDptoLocalDataSource {
  @override
  Future<List<TipoSanitarioViviendaModel>>
      getTiposSanitarioViviendaByDpto() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('TiposSanitarioVivienda_DatosVivienda');
    final result = List<TipoSanitarioViviendaModel>.from(
        res.map((m) => TipoSanitarioViviendaModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTipoSanitarioViviendaByDpto(
      TipoSanitarioViviendaEntity tipoSanitarioViviendaByDpto) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert('TiposSanitarioVivienda_DatosVivienda',
        tipoSanitarioViviendaByDpto.toJson());

    return res;
  }
}
