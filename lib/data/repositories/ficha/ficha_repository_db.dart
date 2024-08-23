import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/ficha.dart';
import '../../../domain/repositories/ficha/ficha_repository_db.dart';
import '../../datasources/local/ficha_local_ds.dart';
import '../../models/estadistica.dart';
import '../../models/ficha.dart';

class FichaRepositoryDBImpl implements FichaRepositoryDB {
  final FichaLocalDataSource fichaLocalDataSource;

  FichaRepositoryDBImpl({required this.fichaLocalDataSource});

  @override
  Future<Either<Failure, FichaModel>> createFichaRepositoryDB(
      FichaEntity ficha) async {
    try {
      final fichaModel = FichaModel.fromEntity(ficha);
      final result = await fichaLocalDataSource.createFicha(fichaModel);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> createFichaCompletaRepositoryDB(
      FichaEntity ficha) async {
    try {
      final fichaModel = FichaModel.fromEntity(ficha);
      await fichaLocalDataSource.createFichaCompleta(fichaModel);

      // return Right(result);
      return const Right(1);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, List<FichaModel>>> loadFichasRepositoryDB(
      int familiaId) async {
    try {
      final result = await fichaLocalDataSource.loadFichas(familiaId);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> deleteFichaRepositoryDB(int fichaId) async {
    try {
      final result = await fichaLocalDataSource.deleteFicha(fichaId);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, List<FichaModel>>>
      loadFichasSincronizadasRepositoryDB() async {
    try {
      final result = await fichaLocalDataSource.loadFichasSincronizadas();

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, List<EstadisticaModel>>>
      loadEstadisticasRepositoryDB() async {
    try {
      final result = await fichaLocalDataSource.loadEstadisticas();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, void>> updateFichaRepositoryDB(
      int fichaIdLocal, int numFicha) async {
    try {
      final result =
          await fichaLocalDataSource.updateFicha(fichaIdLocal, numFicha);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
