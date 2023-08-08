import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/dificultad_acceso_med_tradicional_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/dificultad_acceso_med_tradicional_entity.dart';
import '../../../domain/repositories/dificultad_acceso_med_tradicional/dificultad_acceso_med_tradicional_repository_db.dart';
import '../../datasources/local/dificultad_acceso_med_tradicional_local_ds.dart';

class DificultadAccesoMedTradicionalRepositoryDBImpl
    implements DificultadAccesoMedTradicionalRepositoryDB {
  final DificultadAccesoMedTradicionalLocalDataSource
      dificultadAccesoMedTradicionalLocalDataSource;

  DificultadAccesoMedTradicionalRepositoryDBImpl(
      {required this.dificultadAccesoMedTradicionalLocalDataSource});

  @override
  Future<Either<Failure, List<DificultadAccesoMedTradicionalEntity>>>
      getDificultadesAccesoMedTradicionalRepositoryDB() async {
    try {
      final result = await dificultadAccesoMedTradicionalLocalDataSource
          .getDificultadesAccesoMedTradicional();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveDificultadAccesoMedTradicionalRepositoryDB(
      DificultadAccesoMedTradicionalEntity
          dificultadAccesoMedTradicional) async {
    try {
      final result = await dificultadAccesoMedTradicionalLocalDataSource
          .saveDificultadAccesoMedTradicional(dificultadAccesoMedTradicional);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
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
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
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
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
