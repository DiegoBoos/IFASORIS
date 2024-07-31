import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_documento.dart';
import '../../repositories/tipo_documento/tipo_documento_repository_db.dart';

class TipoDocumentoUsecaseDB {
  final TipoDocumentoRepositoryDB repositoryDB;

  TipoDocumentoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveTipoDocumentoUsecaseDB(
      TipoDocumentoEntity tipoDocumento) {
    return repositoryDB.saveTipoDocumentoRepositoryDB(tipoDocumento);
  }

  Future<Either<Failure, List<TipoDocumentoEntity>>>
      getTiposDocumentoUsecaseDB() {
    return repositoryDB.getTiposDocumentoRepositoryDB();
  }
}
