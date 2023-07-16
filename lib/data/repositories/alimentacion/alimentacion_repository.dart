import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/alimentacion_entity.dart';
import '../../../domain/repositories/alimentacion/alimentacion_repository.dart';
import '../../datasources/remote/alimentacion_remote_ds.dart';

class AlimentacionRepositoryImpl implements AlimentacionRepository {
  final AlimentacionRemoteDataSource alimentacionRemoteDataSource;

  AlimentacionRepositoryImpl({required this.alimentacionRemoteDataSource});

  @override
  Future<Either<Failure, List<AlimentacionEntity>>>
      getAlimentacionesRepository() async {
    try {
      final result = await alimentacionRemoteDataSource.getAlimentaciones();

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
