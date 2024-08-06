import '../../../core/constants.dart';
import '../../models/tipo_documento.dart';

abstract class TipoDocumentoLocalDataSource {
  Future<List<TipoDocumentoModel>> getTiposDocumento();
  Future<int> saveTipoDocumento(TipoDocumentoModel tipoDocumento);
}

class TipoDocumentoLocalDataSourceImpl implements TipoDocumentoLocalDataSource {
  @override
  Future<List<TipoDocumentoModel>> getTiposDocumento() async {
    final res = await supabase.from('TiposDocumento_GrupoFamiliar').select();
    final result = List<TipoDocumentoModel>.from(
        res.map((m) => TipoDocumentoModel.fromJson(m))).toList();

    return result;
  }

  @override
  Future<int> saveTipoDocumento(TipoDocumentoModel tipoDocumento) async {
    final res = await supabase
        .from('TiposDocumento_GrupoFamiliar')
        .insert(tipoDocumento.toJson());

    return res;
  }
}
