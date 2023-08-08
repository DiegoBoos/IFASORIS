import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/tenencia_vivienda_entity.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/repositories/tenencia_vivienda/tenencia_vivienda_repository.dart';
import '../../datasources/remote/tenencia_vivienda_remote_ds.dart';

class TenenciaViviendaRepositoryImpl implements TenenciaViviendaRepository {
  final TenenciaViviendaRemoteDataSource tenenciaViviendaRemoteDataSource;

  TenenciaViviendaRepositoryImpl(
      {required this.tenenciaViviendaRemoteDataSource});

  @override
  Future<Either<Failure, List<TenenciaViviendaEntity>>>
      getTenenciasViviendaRepository(int dtoId) async {
    try {
      final result =
          await tenenciaViviendaRemoteDataSource.getTenenciasVivienda(dtoId);

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
