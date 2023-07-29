import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/servicio_solicitado_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/servicio_solicitado_entity.dart';
import '../../../domain/repositories/servicio_solicitado/servicio_solicitado_repository_db.dart';
import '../../datasources/local/servicio_solicitado_local_ds.dart';

class ServicioSolicitadoRepositoryDBImpl
    implements ServicioSolicitadoRepositoryDB {
  final ServicioSolicitadoLocalDataSource servicioSolicitadoLocalDataSource;

  ServicioSolicitadoRepositoryDBImpl(
      {required this.servicioSolicitadoLocalDataSource});

  @override
  Future<Either<Failure, List<ServicioSolicitadoEntity>>>
      getServiciosSolicitadosRepositoryDB() async {
    try {
      final result =
          await servicioSolicitadoLocalDataSource.getServiciosSolicitados();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveServicioSolicitadoRepositoryDB(
      ServicioSolicitadoEntity servicioSolicitado) async {
    try {
      final result = await servicioSolicitadoLocalDataSource
          .saveServicioSolicitado(servicioSolicitado);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstServicioSolicitado>>>
      getLstServiciosSolicitadosRepositoryDB(
          int? cuidadoSaludCondRiesgoId) async {
    try {
      final result = await servicioSolicitadoLocalDataSource
          .getLstServiciosSolicitados(cuidadoSaludCondRiesgoId);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
