import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/servicio_publico_vivienda/servicio_publico_vivienda_repository.dart';
import '../../datasources/remote/servicio_publico_vivienda_remote_ds.dart';
import '../../models/servicio_publico_vivienda.dart';

class ServicioPublicoViviendaRepositoryImpl
    implements ServicioPublicoViviendaRepository {
  final ServicioPublicoViviendaRemoteDataSource
      servicioPublicoViviendaRemoteDataSource;

  ServicioPublicoViviendaRepositoryImpl(
      {required this.servicioPublicoViviendaRemoteDataSource});

  @override
  Future<Either<Failure, List<ServicioPublicoViviendaModel>>>
      getServiciosPublicosViviendaRepository(int dtoId) async {
    try {
      final result = await servicioPublicoViviendaRemoteDataSource
          .getServiciosPublicosVivienda(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
