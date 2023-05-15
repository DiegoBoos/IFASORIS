import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/tenencia_vivienda_entity.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/repositories/tenencia_vivienda_by_dpto/tenencia_vivienda_by_dpto_repository.dart';
import '../../datasources/remote/tenencia_vivienda_by_dpto_remote_ds.dart';

class TenenciaViviendaByDptoRepositoryImpl
    implements TenenciaViviendaByDptoRepository {
  final TenenciaViviendaByDptoRemoteDataSource
      tenenciaViviendaByDptoRemoteDataSource;

  TenenciaViviendaByDptoRepositoryImpl(
      {required this.tenenciaViviendaByDptoRemoteDataSource});

  @override
  Future<Either<Failure, List<TenenciaViviendaEntity>>>
      getTenenciasViviendaByDptoRepository(int dtoId) async {
    try {
      final result = await tenenciaViviendaByDptoRemoteDataSource
          .getTenenciasViviendaByDpto(dtoId);

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
