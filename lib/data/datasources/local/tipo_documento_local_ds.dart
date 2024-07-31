import '../../../services/connection_sqlite_service.dart';
import '../../models/tipo_documento.dart';

abstract class TipoDocumentoLocalDataSource {
  Future<List<TipoDocumentoModel>> getTiposDocumento();
  Future<int> saveTipoDocumento(TipoDocumentoModel tipoDocumento);
}

class TipoDocumentoLocalDataSourceImpl implements TipoDocumentoLocalDataSource {
  @override
  Future<List<TipoDocumentoModel>> getTiposDocumento() async {
    final db = await ConnectionSQLiteService.db;
    final res = await db.query('TiposDocumento_GrupoFamiliar');
    final result = List<TipoDocumentoModel>.from(
        res.map((m) => TipoDocumentoModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTipoDocumento(TipoDocumentoModel tipoDocumento) async {
    final db = await ConnectionSQLiteService.db;

    final res =
        await db.insert('TiposDocumento_GrupoFamiliar', tipoDocumento.toJson());

    return res;
  }
}
