import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tipo_documento_entity.dart';
import '../../../domain/repositories/tipo_documento/tipo_documento_repository_db.dart';
import '../../datasources/local/tipo_documento_local_ds.dart';

class TipoDocumentoRepositoryDBImpl implements TipoDocumentoRepositoryDB {
  final TipoDocumentoLocalDataSource tipoDocumentoLocalDataSource;

  TipoDocumentoRepositoryDBImpl({required this.tipoDocumentoLocalDataSource});

  @override
  Future<Either<Failure, List<TipoDocumentoEntity>>>
      getTiposDocumentoRepositoryDB() async {
    try {
      final result = await tipoDocumentoLocalDataSource.getTiposDocumento();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTipoDocumentoRepositoryDB(
      TipoDocumentoEntity tipoDocumento) async {
    try {
      final result =
          await tipoDocumentoLocalDataSource.saveTipoDocumento(tipoDocumento);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
