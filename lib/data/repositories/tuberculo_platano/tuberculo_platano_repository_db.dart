import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/tuberculo_platano_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tuberculo_platano_entity.dart';
import '../../../domain/repositories/tuberculo_platano/tuberculo_platano_repository_db.dart';
import '../../datasources/local/tuberculo_platano_local_ds.dart';

class TuberculoPlatanoRepositoryDBImpl implements TuberculoPlatanoRepositoryDB {
  final TuberculoPlatanoLocalDataSource tuberculoPlatanoLocalDataSource;

  TuberculoPlatanoRepositoryDBImpl(
      {required this.tuberculoPlatanoLocalDataSource});

  @override
  Future<Either<Failure, List<TuberculoPlatanoEntity>>>
      getTuberculosPlatanosRepositoryDB() async {
    try {
      final result =
          await tuberculoPlatanoLocalDataSource.getTuberculosPlatanos();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTuberculoPlatanoRepositoryDB(
      TuberculoPlatanoEntity tuberculoPlatano) async {
    try {
      final result = await tuberculoPlatanoLocalDataSource
          .saveTuberculoPlatano(tuberculoPlatano);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveUbicacionTuberculosPlatanosRepositoryDB(
      int ubicacionId, List<LstTuberculo> lstTuberculos) async {
    try {
      final result = await tuberculoPlatanoLocalDataSource
          .saveUbicacionTuberculosPlatanos(ubicacionId, lstTuberculos);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstTuberculo>>>
      getUbicacionTuberculosPlatanosRepositoryDB(int? ubicacionId) async {
    try {
      final result = await tuberculoPlatanoLocalDataSource
          .getUbicacionTuberculosPlatanos(ubicacionId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
