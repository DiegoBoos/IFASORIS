import '../../../domain/entities/tipo_documento_entity.dart';
import '../../../services/connection_sqlite_service.dart';
import '../../models/tipo_documento_model.dart';

abstract class TipoDocumentoLocalDataSource {
  Future<List<TipoDocumentoModel>> getTiposDocumento();
  Future<int> saveTipoDocumento(TipoDocumentoEntity tipoDocumento);
}

class TipoDocumentoLocalDataSourceImpl implements TipoDocumentoLocalDataSource {
  @override
  Future<List<TipoDocumentoModel>> getTiposDocumento() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('TiposDocumentos_AspectosSocioEconomicos');
    final result = List<TipoDocumentoModel>.from(
        res.map((m) => TipoDocumentoModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTipoDocumento(TipoDocumentoEntity tipoDocumento) async {
    final db = await ConnectionSQLiteService.db;

    final res = await db.insert(
        'TiposDocumentos_AspectosSocioEconomicos', tipoDocumento.toJson());

    return res;
  }
}
