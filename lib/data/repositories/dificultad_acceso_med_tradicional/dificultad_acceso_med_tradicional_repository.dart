import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/dificultad_acceso_med_tradicional_entity.dart';
import '../../../domain/repositories/dificultad_acceso_med_tradicional/dificultad_acceso_med_tradicional_repository.dart';
import '../../datasources/remote/dificultad_acceso_med_tradicional_remote_ds.dart';

class DificultadAccesoMedTradicionalRepositoryImpl
    implements DificultadAccesoMedTradicionalRepository {
  final DificultadAccesoMedTradicionalRemoteDataSource
      dificultadAccesoMedTradicionalRemoteDataSource;

  DificultadAccesoMedTradicionalRepositoryImpl(
      {required this.dificultadAccesoMedTradicionalRemoteDataSource});

  @override
  Future<Either<Failure, List<DificultadAccesoMedTradicionalEntity>>>
      getDificultadesAccesoMedTradicionalRepository(int dtoId) async {
    try {
      final result = await dificultadAccesoMedTradicionalRemoteDataSource
          .getDificultadesAccesoMedTradicional(dtoId);

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
