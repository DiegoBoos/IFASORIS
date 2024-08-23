import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/dificultad_acceso_ca.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/dificultad_acceso_ca.dart';
import '../../../domain/repositories/dificultad_acceso_ca/dificultad_acceso_ca_repository_db.dart';
import '../../datasources/local/dificultad_acceso_ca_local_ds.dart';

class DificultadAccesoCARepositoryDBImpl
    implements DificultadAccesoCARepositoryDB {
  final DificultadAccesoCALocalDataSource dificultadAccesoCALocalDataSource;

  DificultadAccesoCARepositoryDBImpl(
      {required this.dificultadAccesoCALocalDataSource});

  @override
  Future<Either<Failure, List<DificultadAccesoCAModel>>>
      getDificultadesAccesoCARepositoryDB() async {
    try {
      final result =
          await dificultadAccesoCALocalDataSource.getDificultadesAccesoCA();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveDificultadAccesoCARepositoryDB(
      DificultadAccesoCAEntity dificultadAccesoCA) async {
    try {
      final dificultadAccesoCAModel =
          DificultadAccesoCAModel.fromEntity(dificultadAccesoCA);
      final result = await dificultadAccesoCALocalDataSource
          .saveDificultadAccesoCA(dificultadAccesoCAModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveUbicacionDificultadesAccesoRepositoryDB(
      int ubicacionId,
      List<LstDificultadAccesoAtencion> lstDificultadAccesoAtencion) async {
    try {
      final result = await dificultadAccesoCALocalDataSource
          .saveUbicacionDificultadesAcceso(
              ubicacionId, lstDificultadAccesoAtencion);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, List<LstDificultadAccesoAtencion>>>
      getUbicacionDificultadesAccesoRepositoryDB(int? ubicacionId) async {
    try {
      final result = await dificultadAccesoCALocalDataSource
          .getUbicacionDificultadesAcceso(ubicacionId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
