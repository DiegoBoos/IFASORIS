import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/genero_entity.dart';
import '../../../domain/repositories/genero/genero_repository_db.dart';
import '../../datasources/local/genero_local_ds.dart';

class GeneroRepositoryDBImpl implements GeneroRepositoryDB {
  final GeneroLocalDataSource generoLocalDataSource;

  GeneroRepositoryDBImpl({required this.generoLocalDataSource});

  @override
  Future<Either<Failure, List<GeneroEntity>>> getGenerosRepositoryDB() async {
    try {
      final result = await generoLocalDataSource.getGeneros();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveGeneroRepositoryDB(
      GeneroEntity genero) async {
    try {
      final result = await generoLocalDataSource.saveGenero(genero);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
