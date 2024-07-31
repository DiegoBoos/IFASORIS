import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/actividad_fisica/actividad_fisica_repository.dart';
import '../../datasources/remote/actividad_fisica_remote_ds.dart';
import '../../models/actividad_fisica.dart';

class ActividadFisicaRepositoryImpl implements ActividadFisicaRepository {
  final ActividadFisicaRemoteDataSource actividadFisicaRemoteDataSource;

  ActividadFisicaRepositoryImpl(
      {required this.actividadFisicaRemoteDataSource});

  @override
  Future<Either<Failure, List<ActividadFisicaModel>>>
      getActividadesFisicasRepository() async {
    try {
      final result =
          await actividadFisicaRemoteDataSource.getActividadesFisicas();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
