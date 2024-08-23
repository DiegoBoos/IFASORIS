import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tipo_documento.dart';
import '../../../domain/repositories/tipo_documento/tipo_documento_repository_db.dart';
import '../../datasources/local/tipo_documento_local_ds.dart';
import '../../models/tipo_documento.dart';

class TipoDocumentoRepositoryDBImpl implements TipoDocumentoRepositoryDB {
  final TipoDocumentoLocalDataSource tipoDocumentoLocalDataSource;

  TipoDocumentoRepositoryDBImpl({required this.tipoDocumentoLocalDataSource});

  @override
  Future<Either<Failure, List<TipoDocumentoModel>>>
      getTiposDocumentoRepositoryDB() async {
    try {
      final result = await tipoDocumentoLocalDataSource.getTiposDocumento();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveTipoDocumentoRepositoryDB(
      TipoDocumentoEntity tipoDocumento) async {
    try {
      final tipoDocumentoModel = TipoDocumentoModel.fromEntity(tipoDocumento);
      final result = await tipoDocumentoLocalDataSource
          .saveTipoDocumento(tipoDocumentoModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
