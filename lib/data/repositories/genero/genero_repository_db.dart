import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/genero.dart';
import '../../../domain/repositories/genero/genero_repository_db.dart';
import '../../datasources/local/genero_local_ds.dart';
import '../../models/genero.dart';

class GeneroRepositoryDBImpl implements GeneroRepositoryDB {
  final GeneroLocalDataSource generoLocalDataSource;

  GeneroRepositoryDBImpl({required this.generoLocalDataSource});

  @override
  Future<Either<Failure, List<GeneroModel>>> getGenerosRepositoryDB() async {
    try {
      final result = await generoLocalDataSource.getGeneros();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveGeneroRepositoryDB(
      GeneroEntity genero) async {
    try {
      final generoModel = GeneroModel.fromEntity(genero);
      final result = await generoLocalDataSource.saveGenero(generoModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
