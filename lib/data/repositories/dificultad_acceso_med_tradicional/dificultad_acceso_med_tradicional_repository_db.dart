import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/dificultad_acceso_med_tradicional.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/dificultad_acceso_med_tradicional.dart';
import '../../../domain/repositories/dificultad_acceso_med_tradicional/dificultad_acceso_med_tradicional_repository_db.dart';
import '../../datasources/local/dificultad_acceso_med_tradicional_local_ds.dart';

class DificultadAccesoMedTradicionalRepositoryDBImpl
    implements DificultadAccesoMedTradicionalRepositoryDB {
  final DificultadAccesoMedTradicionalLocalDataSource
      dificultadAccesoMedTradicionalLocalDataSource;

  DificultadAccesoMedTradicionalRepositoryDBImpl(
      {required this.dificultadAccesoMedTradicionalLocalDataSource});

  @override
  Future<Either<Failure, List<DificultadAccesoMedTradicionalModel>>>
      getDificultadesAccesoMedTradicionalRepositoryDB() async {
    try {
      final result = await dificultadAccesoMedTradicionalLocalDataSource
          .getDificultadesAccesoMedTradicional();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveDificultadAccesoMedTradicionalRepositoryDB(
      DificultadAccesoMedTradicionalEntity
          dificultadAccesoMedTradicional) async {
    try {
      final dificultadAccesoMedTradicionalModel =
          DificultadAccesoMedTradicionalModel.fromEntity(
              dificultadAccesoMedTradicional);
      final result = await dificultadAccesoMedTradicionalLocalDataSource
          .saveDificultadAccesoMedTradicional(
              dificultadAccesoMedTradicionalModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveUbicacionAccesoMedTradicionalRepositoryDB(
      int ubicacionId,
      List<LstDificultadAccesoMedTradicional>
          lstDificultadAccesoMedTradicional) async {
    try {
      final result = await dificultadAccesoMedTradicionalLocalDataSource
          .saveUbicacionAccesoMedTradicional(
              ubicacionId, lstDificultadAccesoMedTradicional);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, List<LstDificultadAccesoMedTradicional>>>
      getUbicacionDificultadesAccesoMedTradicionalRepositoryDB(
          int? ubicacionId) async {
    try {
      final result = await dificultadAccesoMedTradicionalLocalDataSource
          .getUbicacionDificultadesAccesoMedTradicional(ubicacionId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
