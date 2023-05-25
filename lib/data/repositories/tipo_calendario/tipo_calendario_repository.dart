import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tipo_calendario_entity.dart';
import '../../../domain/repositories/tipo_calendario/tipo_calendario_repository.dart';
import '../../datasources/remote/tipo_calendario_remote_ds.dart';

class TipoCalendarioRepositoryImpl implements TipoCalendarioRepository {
  final TipoCalendarioRemoteDataSource tipoCalendarioRemoteDataSource;

  TipoCalendarioRepositoryImpl({required this.tipoCalendarioRemoteDataSource});

  @override
  Future<Either<Failure, List<TipoCalendarioEntity>>>
      getTiposCalendarioRepository() async {
    try {
      final result = await tipoCalendarioRemoteDataSource.getTiposCalendario();

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
