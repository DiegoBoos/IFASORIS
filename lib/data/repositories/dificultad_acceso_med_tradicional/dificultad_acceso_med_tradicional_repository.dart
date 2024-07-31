import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/dificultad_acceso_med_tradicional/dificultad_acceso_med_tradicional_repository.dart';
import '../../datasources/remote/dificultad_acceso_med_tradicional_remote_ds.dart';
import '../../models/dificultad_acceso_med_tradicional.dart';

class DificultadAccesoMedTradicionalRepositoryImpl
    implements DificultadAccesoMedTradicionalRepository {
  final DificultadAccesoMedTradicionalRemoteDataSource
      dificultadAccesoMedTradicionalRemoteDataSource;

  DificultadAccesoMedTradicionalRepositoryImpl(
      {required this.dificultadAccesoMedTradicionalRemoteDataSource});

  @override
  Future<Either<Failure, List<DificultadAccesoMedTradicionalModel>>>
      getDificultadesAccesoMedTradicionalRepository(int dtoId) async {
    try {
      final result = await dificultadAccesoMedTradicionalRemoteDataSource
          .getDificultadesAccesoMedTradicional(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
