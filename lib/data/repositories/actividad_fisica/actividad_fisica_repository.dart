import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/actividad_fisica_entity.dart';
import '../../../domain/repositories/actividad_fisica/actividad_fisica_repository.dart';
import '../../datasources/remote/actividad_fisica_remote_ds.dart';

class ActividadFisicaRepositoryImpl implements ActividadFisicaRepository {
  final ActividadFisicaRemoteDataSource actividadFisicaRemoteDataSource;

  ActividadFisicaRepositoryImpl(
      {required this.actividadFisicaRemoteDataSource});

  @override
  Future<Either<Failure, List<ActividadFisicaEntity>>>
      getActividadesFisicasRepository() async {
    try {
      final result =
          await actividadFisicaRemoteDataSource.getActividadesFisicas();

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
