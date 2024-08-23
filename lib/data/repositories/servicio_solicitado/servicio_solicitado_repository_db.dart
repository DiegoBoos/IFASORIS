import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/servicio_solicitado.dart';
import '../../../domain/repositories/servicio_solicitado/servicio_solicitado_repository_db.dart';
import '../../datasources/local/servicio_solicitado_local_ds.dart';
import '../../models/servicio_solicitado.dart';

class ServicioSolicitadoRepositoryDBImpl
    implements ServicioSolicitadoRepositoryDB {
  final ServicioSolicitadoLocalDataSource servicioSolicitadoLocalDataSource;

  ServicioSolicitadoRepositoryDBImpl(
      {required this.servicioSolicitadoLocalDataSource});

  @override
  Future<Either<Failure, List<ServicioSolicitadoModel>>>
      getServiciosSolicitadosRepositoryDB() async {
    try {
      final result =
          await servicioSolicitadoLocalDataSource.getServiciosSolicitados();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveServicioSolicitadoRepositoryDB(
      ServicioSolicitadoEntity servicioSolicitado) async {
    try {
      final servicioSolicitadoModel =
          ServicioSolicitadoModel.fromEntity(servicioSolicitado);
      final result = await servicioSolicitadoLocalDataSource
          .saveServicioSolicitado(servicioSolicitadoModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
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
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveServiciosSolicitadosRepositoryDB(
      int cuidadoSaludCondRiesgoId,
      List<LstServicioSolicitado> lstServiciosSolicitados) async {
    try {
      final result =
          await servicioSolicitadoLocalDataSource.saveServiciosSolicitados(
              cuidadoSaludCondRiesgoId, lstServiciosSolicitados);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
