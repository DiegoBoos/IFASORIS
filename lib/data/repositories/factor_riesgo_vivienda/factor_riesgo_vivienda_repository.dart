import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/factor_riesgo_vivienda_entity.dart';
import '../../../domain/repositories/factor_riesgo_vivienda/factor_riesgo_vivienda_repository.dart';
import '../../datasources/remote/factor_riesgo_vivienda_remote_ds.dart';

class FactorRiesgoViviendaRepositoryImpl
    implements FactorRiesgoViviendaRepository {
  final FactorRiesgoViviendaRemoteDataSource
      factorRiesgoViviendaRemoteDataSource;

  FactorRiesgoViviendaRepositoryImpl(
      {required this.factorRiesgoViviendaRemoteDataSource});

  @override
  Future<Either<Failure, List<FactorRiesgoViviendaEntity>>>
      getFactoresRiesgoViviendaRepository(int dtoId) async {
    try {
      final result = await factorRiesgoViviendaRemoteDataSource
          .getFactoresRiesgoVivienda(dtoId);

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
