import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/especialidad_med_tradicional_by_dpto_entity.dart';
import '../../../domain/repositories/especialidad_med_tradicional_by_dpto/especialidad_med_tradicional_by_dpto_repository.dart';
import '../../datasources/remote/especialidad_med_tradicional_by_dpto_remote_ds.dart';

class EspecialidadMedTradicionalByDptoRepositoryImpl
    implements EspecialidadMedTradicionalByDptoRepository {
  final EspecialidadMedTradicionalByDptoRemoteDataSource
      especialidadMedTradicionalByDptoRemoteDataSource;

  EspecialidadMedTradicionalByDptoRepositoryImpl(
      {required this.especialidadMedTradicionalByDptoRemoteDataSource});

  @override
  Future<Either<Failure, List<EspecialidadMedTradicionalByDptoEntity>>>
      getEspecialidadesMedTradicionalByDptoRepository(int dtoId) async {
    try {
      final result = await especialidadMedTradicionalByDptoRemoteDataSource
          .getEspecialidadesMedTradicionalByDpto(dtoId);

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
