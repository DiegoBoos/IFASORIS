import '../../models/tipo_documento.dart';

abstract class TipoDocumentoLocalDataSource {
  Future<List<TipoDocumentoModel>> getTiposDocumento();
  Future<int> saveTipoDocumento(TipoDocumentoModel tipoDocumento);
}

class TipoDocumentoLocalDataSourceImpl implements TipoDocumentoLocalDataSource {
  @override
  Future<List<TipoDocumentoModel>> getTiposDocumento() async {
    final res = await supabase.from(.select()'TiposDocumento_GrupoFamiliar');
    final result = List<TipoDocumentoModel>.from(
        res.map((m) => TipoDocumentoModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTipoDocumento(TipoDocumentoModel tipoDocumento) async {
    final res = await supabase
        .from(
        .insert('TiposDocumento_GrupoFamiliar', tipoDocumento.toJson());

    return res;
  }
}
