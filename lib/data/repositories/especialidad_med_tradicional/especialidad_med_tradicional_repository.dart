import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/especialidad_med_tradicional/especialidad_med_tradicional_repository.dart';
import '../../datasources/remote/especialidad_med_tradicional_remote_ds.dart';
import '../../models/especialidad_med_tradicional.dart';

class EspecialidadMedTradicionalRepositoryImpl
    implements EspecialidadMedTradicionalRepository {
  final EspecialidadMedTradicionalRemoteDataSource
      especialidadMedTradicionalRemoteDataSource;

  EspecialidadMedTradicionalRepositoryImpl(
      {required this.especialidadMedTradicionalRemoteDataSource});

  @override
  Future<Either<Failure, List<EspecialidadMedTradicionalModel>>>
      getEspecialidadesMedTradicionalRepository(int dtoId) async {
    try {
      final result = await especialidadMedTradicionalRemoteDataSource
          .getEspecialidadesMedTradicional(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
