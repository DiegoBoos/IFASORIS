import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/metodo_planificacion_entity.dart';
import '../../../domain/repositories/metodo_planificacion/metodo_planificacion_repository.dart';
import '../../datasources/remote/metodo_planificacion_remote_ds.dart';

class MetodoPlanificacionRepositoryImpl
    implements MetodoPlanificacionRepository {
  final MetodoPlanificacionRemoteDataSource metodoPlanificacionRemoteDataSource;

  MetodoPlanificacionRepositoryImpl(
      {required this.metodoPlanificacionRemoteDataSource});

  @override
  Future<Either<Failure, List<MetodoPlanificacionEntity>>>
      getMetodosPlanificacionRepository() async {
    try {
      final result =
          await metodoPlanificacionRemoteDataSource.getMetodosPlanificacion();

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
