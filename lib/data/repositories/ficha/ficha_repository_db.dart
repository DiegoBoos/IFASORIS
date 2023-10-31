import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/ficha_entity.dart';
import '../../../domain/repositories/ficha/ficha_repository_db.dart';
import '../../datasources/local/ficha_local_ds.dart';

class FichaRepositoryDBImpl implements FichaRepositoryDB {
  final FichaLocalDataSource fichaLocalDataSource;

  FichaRepositoryDBImpl({required this.fichaLocalDataSource});

  @override
  Future<Either<Failure, FichaEntity>> createFichaRepositoryDB(
      FichaEntity ficha) async {
    try {
      final result = await fichaLocalDataSource.createFicha(ficha);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> createFichaCompletaRepositoryDB(
      FichaEntity ficha) async {
    try {
      // final result = await fichaLocalDataSource.createFichaCompleta(ficha);
      await fichaLocalDataSource.createFichaCompleta(ficha);

      // return Right(result);
      return const Right(1);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<FichaEntity>>> loadFichasRepositoryDB(
      int familiaId) async {
    try {
      final result = await fichaLocalDataSource.loadFichas(familiaId);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> deleteFichaRepositoryDB(int fichaId) async {
    try {
      final result = await fichaLocalDataSource.deleteFicha(fichaId);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<FichaEntity>>>
      loadFichasDiligenciadasRepositoryDB(int familiaId) async {
    try {
      final result =
          await fichaLocalDataSource.loadFichasDiligenciadas(familiaId);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
