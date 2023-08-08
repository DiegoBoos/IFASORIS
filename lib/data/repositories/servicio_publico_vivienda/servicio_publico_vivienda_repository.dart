import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/servicio_publico_vivienda_entity.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/repositories/servicio_publico_vivienda/servicio_publico_vivienda_repository.dart';
import '../../datasources/remote/servicio_publico_vivienda_remote_ds.dart';

class ServicioPublicoViviendaRepositoryImpl
    implements ServicioPublicoViviendaRepository {
  final ServicioPublicoViviendaRemoteDataSource
      servicioPublicoViviendaRemoteDataSource;

  ServicioPublicoViviendaRepositoryImpl(
      {required this.servicioPublicoViviendaRemoteDataSource});

  @override
  Future<Either<Failure, List<ServicioPublicoViviendaEntity>>>
      getServiciosPublicosViviendaRepository(int dtoId) async {
    try {
      final result = await servicioPublicoViviendaRemoteDataSource
          .getServiciosPublicosVivienda(dtoId);

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
