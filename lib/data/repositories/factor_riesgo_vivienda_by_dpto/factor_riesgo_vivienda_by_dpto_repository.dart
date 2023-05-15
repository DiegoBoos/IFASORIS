import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/factor_riesgo_vivienda_entity.dart';
import '../../../domain/repositories/factor_riesgo_vivienda_by_dpto/factor_riesgo_vivienda_by_dpto_repository.dart';
import '../../datasources/remote/factor_riesgo_vivienda_by_dpto_remote_ds.dart';

class FactorRiesgoViviendaByDptoRepositoryImpl
    implements FactorRiesgoViviendaByDptoRepository {
  final FactorRiesgoViviendaByDptoRemoteDataSource
      factorRiesgoViviendaByDptoRemoteDataSource;

  FactorRiesgoViviendaByDptoRepositoryImpl(
      {required this.factorRiesgoViviendaByDptoRemoteDataSource});

  @override
  Future<Either<Failure, List<FactorRiesgoViviendaEntity>>>
      getFactoresRiesgoViviendaByDptoRepository(int dtoId) async {
    try {
      final result = await factorRiesgoViviendaByDptoRemoteDataSource
          .getFactoresRiesgoViviendaByDpto(dtoId);

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
