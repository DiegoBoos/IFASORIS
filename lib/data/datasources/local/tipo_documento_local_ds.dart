import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../models/tipo_documento.dart';

abstract class TipoDocumentoLocalDataSource {
  Future<List<TipoDocumentoModel>> getTiposDocumento();
  Future<int> saveTipoDocumento(TipoDocumentoModel tipoDocumento);
}

class TipoDocumentoLocalDataSourceImpl implements TipoDocumentoLocalDataSource {
  @override
  Future<List<TipoDocumentoModel>> getTiposDocumento() async {
    try {
      final res = await supabase.from('tiposdocumento_grupofamiliar').select();
      final result = List<TipoDocumentoModel>.from(
          res.map((m) => TipoDocumentoModel.fromJson(m))).toList();

      return result;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }

  @override
  Future<int> saveTipoDocumento(TipoDocumentoModel tipoDocumento) async {
    try {
      await supabase
          .from('tiposdocumento_grupofamiliar')
          .upsert(tipoDocumento.toJson());

      return tipoDocumento.tipoDocumentoId!;
    } on PostgrestException catch (error) {
      throw DatabaseFailure([error.message]);
    } catch (_) {
      throw const DatabaseFailure([unexpectedErrorMessage]);
    }
  }
}
