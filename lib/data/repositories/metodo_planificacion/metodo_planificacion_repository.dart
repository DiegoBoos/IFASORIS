import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/metodo_planificacion/metodo_planificacion_repository.dart';
import '../../datasources/remote/metodo_planificacion_remote_ds.dart';
import '../../models/metodo_planificacion.dart';

class MetodoPlanificacionRepositoryImpl
    implements MetodoPlanificacionRepository {
  final MetodoPlanificacionRemoteDataSource metodoPlanificacionRemoteDataSource;

  MetodoPlanificacionRepositoryImpl(
      {required this.metodoPlanificacionRemoteDataSource});

  @override
  Future<Either<Failure, List<MetodoPlanificacionModel>>>
      getMetodosPlanificacionRepository() async {
    try {
      final result =
          await metodoPlanificacionRemoteDataSource.getMetodosPlanificacion();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
