import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/tenencia_vivienda/tenencia_vivienda_repository.dart';
import '../../datasources/remote/tenencia_vivienda_remote_ds.dart';
import '../../models/tenencia_vivienda.dart';

class TenenciaViviendaRepositoryImpl implements TenenciaViviendaRepository {
  final TenenciaViviendaRemoteDataSource tenenciaViviendaRemoteDataSource;

  TenenciaViviendaRepositoryImpl(
      {required this.tenenciaViviendaRemoteDataSource});

  @override
  Future<Either<Failure, List<TenenciaViviendaModel>>>
      getTenenciasViviendaRepository(int dtoId) async {
    try {
      final result =
          await tenenciaViviendaRemoteDataSource.getTenenciasVivienda(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
