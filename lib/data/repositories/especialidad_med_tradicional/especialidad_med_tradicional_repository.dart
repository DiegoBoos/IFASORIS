import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/especialidad_med_tradicional_entity.dart';
import '../../../domain/repositories/especialidad_med_tradicional/especialidad_med_tradicional_repository.dart';
import '../../datasources/remote/especialidad_med_tradicional_remote_ds.dart';

class EspecialidadMedTradicionalRepositoryImpl
    implements EspecialidadMedTradicionalRepository {
  final EspecialidadMedTradicionalRemoteDataSource
      especialidadMedTradicionalRemoteDataSource;

  EspecialidadMedTradicionalRepositoryImpl(
      {required this.especialidadMedTradicionalRemoteDataSource});

  @override
  Future<Either<Failure, List<EspecialidadMedTradicionalEntity>>>
      getEspecialidadesMedTradicionalRepository(int dtoId) async {
    try {
      final result = await especialidadMedTradicionalRemoteDataSource
          .getEspecialidadesMedTradicional(dtoId);

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
