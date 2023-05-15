import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/servicio_publico_vivienda_entity.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/repositories/servicio_publico_vivienda_by_dpto/servicio_publico_vivienda_by_dpto_repository.dart';
import '../../datasources/remote/servicio_publico_vivienda_by_dpto_remote_ds.dart';

class ServicioPublicoViviendaByDptoRepositoryImpl
    implements ServicioPublicoViviendaByDptoRepository {
  final ServicioPublicoViviendaByDptoRemoteDataSource
      servicioPublicoViviendaByDptoRemoteDataSource;

  ServicioPublicoViviendaByDptoRepositoryImpl(
      {required this.servicioPublicoViviendaByDptoRemoteDataSource});

  @override
  Future<Either<Failure, List<ServicioPublicoViviendaEntity>>>
      getServiciosPublicosViviendaByDptoRepository(int dtoId) async {
    try {
      final result = await servicioPublicoViviendaByDptoRemoteDataSource
          .getServiciosPublicosViviendaByDpto(dtoId);

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
