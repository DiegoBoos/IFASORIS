import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/servicio_solicitado/servicio_solicitado_repository.dart';
import '../../datasources/remote/servicio_solicitado_remote_ds.dart';
import '../../models/servicio_solicitado.dart';

class ServicioSolicitadoRepositoryImpl implements ServicioSolicitadoRepository {
  final ServicioSolicitadoRemoteDataSource servicioSolicitadoRemoteDataSource;

  ServicioSolicitadoRepositoryImpl(
      {required this.servicioSolicitadoRemoteDataSource});

  @override
  Future<Either<Failure, List<ServicioSolicitadoModel>>>
      getServiciosSolicitadosRepository() async {
    try {
      final result =
          await servicioSolicitadoRemoteDataSource.getServiciosSolicitados();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
