import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/tuberculo_platano.dart';
import '../../../domain/repositories/tuberculo_platano/tuberculo_platano_repository_db.dart';
import '../../datasources/local/tuberculo_platano_local_ds.dart';
import '../../models/tuberculo_platano.dart';

class TuberculoPlatanoRepositoryDBImpl implements TuberculoPlatanoRepositoryDB {
  final TuberculoPlatanoLocalDataSource tuberculoPlatanoLocalDataSource;

  TuberculoPlatanoRepositoryDBImpl(
      {required this.tuberculoPlatanoLocalDataSource});

  @override
  Future<Either<Failure, List<TuberculoPlatanoModel>>>
      getTuberculosPlatanosRepositoryDB() async {
    try {
      final result =
          await tuberculoPlatanoLocalDataSource.getTuberculosPlatanos();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTuberculoPlatanoRepositoryDB(
      TuberculoPlatanoEntity tuberculoPlatano) async {
    try {
      final tuberculoPlatanoModel =
          TuberculoPlatanoModel.fromEntity(tuberculoPlatano);
      final result = await tuberculoPlatanoLocalDataSource
          .saveTuberculoPlatano(tuberculoPlatanoModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
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
    } on ServerFailure {
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
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
