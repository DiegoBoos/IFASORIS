import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_documento_entity.dart';

abstract class TipoDocumentoRepositoryDB {
  Future<Either<Failure, int>> saveTipoDocumentoRepositoryDB(
      TipoDocumentoEntity tipoDocumento);

  Future<Either<Failure, List<TipoDocumentoEntity>>>
      getTiposDocumentoRepositoryDB();
}
