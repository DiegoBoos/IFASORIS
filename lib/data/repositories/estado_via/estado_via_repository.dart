import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/estado_via_entity.dart';
import '../../../domain/repositories/estado_via/estado_via_repository.dart';
import '../../datasources/remote/estado_via_remote_ds.dart';

class EstadoViaRepositoryImpl implements EstadoViaRepository {
  final EstadoViaRemoteDataSource estadoViaRemoteDataSource;

  EstadoViaRepositoryImpl({required this.estadoViaRemoteDataSource});

  @override
  Future<Either<Failure, List<EstadoViaEntity>>>
      getEstadoViasRepository() async {
    try {
      final result = await estadoViaRemoteDataSource.getEstadoVias();

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
