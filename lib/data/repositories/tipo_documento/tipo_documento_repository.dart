import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tipo_documento_entity.dart';
import '../../../domain/repositories/tipo_documento/tipo_documento_repository.dart';
import '../../datasources/remote/tipo_documento_remote_ds.dart';

class TipoDocumentoRepositoryImpl implements TipoDocumentoRepository {
  final TipoDocumentoRemoteDataSource tipoDocumentoRemoteDataSource;

  TipoDocumentoRepositoryImpl({required this.tipoDocumentoRemoteDataSource});

  @override
  Future<Either<Failure, List<TipoDocumentoEntity>>>
      getTiposDocumentoRepository() async {
    try {
      final result = await tipoDocumentoRemoteDataSource.getTiposDocumento();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
