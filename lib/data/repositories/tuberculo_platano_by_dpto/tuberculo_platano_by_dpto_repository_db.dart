import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/tuberculo_platano_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tuberculo_platano_entity.dart';
import '../../../domain/repositories/tuberculo_platano_by_dpto/tuberculo_platano_by_dpto_repository_db.dart';
import '../../datasources/local/tuberculo_platano_by_dpto_local_ds.dart';

class TuberculoPlatanoByDptoRepositoryDBImpl
    implements TuberculoPlatanoByDptoRepositoryDB {
  final TuberculoPlatanoByDptoLocalDataSource
      tuberculoPlatanoByDptoLocalDataSource;

  TuberculoPlatanoByDptoRepositoryDBImpl(
      {required this.tuberculoPlatanoByDptoLocalDataSource});

  @override
  Future<Either<Failure, List<TuberculoPlatanoEntity>>>
      getTuberculosPlatanosByDptoRepositoryDB() async {
    try {
      final result = await tuberculoPlatanoByDptoLocalDataSource
          .getTuberculosPlatanosByDpto();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveTuberculoPlatanoByDptoRepositoryDB(
      TuberculoPlatanoEntity tuberculoPlatano) async {
    try {
      final result = await tuberculoPlatanoByDptoLocalDataSource
          .saveTuberculoPlatanoByDpto(tuberculoPlatano);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveUbicacionTuberculosPlatanosRepositoryDB(
      int ubicacionId, List<LstTuberculo> lstTuberculos) async {
    try {
      final result = await tuberculoPlatanoByDptoLocalDataSource
          .saveUbicacionTuberculosPlatanos(ubicacionId, lstTuberculos);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstTuberculo>>>
      getUbicacionTuberculosPlatanosRepositoryDB(int? ubicacionId) async {
    try {
      final result = await tuberculoPlatanoByDptoLocalDataSource
          .getUbicacionTuberculosPlatanos(ubicacionId);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
