import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/cuidado_salud_cond_riesgo_entity.dart';
import '../../../domain/repositories/cuidado_salud_cond_riesgo/cuidado_salud_cond_riesgo_repository.dart';
import '../../datasources/remote/cuidado_salud_cond_riesgo_remote_ds.dart';

class CuidadoSaludCondRiesgoRepositoryImpl
    implements CuidadoSaludCondRiesgoRepository {
  final CuidadoSaludCondRiesgoRemoteDataSource
      cuidadoSaludCondRiesgoRemoteDataSource;

  CuidadoSaludCondRiesgoRepositoryImpl(
      {required this.cuidadoSaludCondRiesgoRemoteDataSource});

  @override
  Future<Either<Failure, CuidadoSaludCondRiesgoEntity>>
      uploadCuidadoSaludCondRiesgoRepository() async {
    try {
      final result = await cuidadoSaludCondRiesgoRemoteDataSource
          .uploadCuidadoSaludCondRiesgo();

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
