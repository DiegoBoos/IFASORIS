import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/dificultad_acceso_med_tradicional_entity.dart';
import '../../../domain/repositories/dificultad_acceso_med_tradicional_by_dpto/dificultad_acceso_med_tradicional_by_dpto_repository.dart';
import '../../datasources/remote/dificultad_acceso_med_tradicional_by_dpto_remote_ds.dart';

class DificultadAccesoMedTradicionalByDptoRepositoryImpl
    implements DificultadAccesoMedTradicionalByDptoRepository {
  final DificultadAccesoMedTradicionalByDptoRemoteDataSource
      dificultadAccesoMedTradicionalByDptoRemoteDataSource;

  DificultadAccesoMedTradicionalByDptoRepositoryImpl(
      {required this.dificultadAccesoMedTradicionalByDptoRemoteDataSource});

  @override
  Future<Either<Failure, List<DificultadAccesoMedTradicionalEntity>>>
      getDificultadesAccesoMedTradicionalByDptoRepository(int dtoId) async {
    try {
      final result = await dificultadAccesoMedTradicionalByDptoRemoteDataSource
          .getDificultadesAccesoMedTradicionalByDpto(dtoId);

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
