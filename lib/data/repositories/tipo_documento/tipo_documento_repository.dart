import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/tipo_documento/tipo_documento_repository.dart';
import '../../datasources/remote/tipo_documento_remote_ds.dart';
import '../../models/tipo_documento.dart';

class TipoDocumentoRepositoryImpl implements TipoDocumentoRepository {
  final TipoDocumentoRemoteDataSource tipoDocumentoRemoteDataSource;

  TipoDocumentoRepositoryImpl({required this.tipoDocumentoRemoteDataSource});

  @override
  Future<Either<Failure, List<TipoDocumentoModel>>>
      getTiposDocumentoRepository() async {
    try {
      final result = await tipoDocumentoRemoteDataSource.getTiposDocumento();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
