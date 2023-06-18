import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/etnia_entity.dart';
import '../../../domain/repositories/etnia/etnia_repository_db.dart';
import '../../datasources/local/etnia_local_ds.dart';

class EtniaRepositoryDBImpl implements EtniaRepositoryDB {
  final EtniaLocalDataSource etniaLocalDataSource;

  EtniaRepositoryDBImpl({required this.etniaLocalDataSource});

  @override
  Future<Either<Failure, List<EtniaEntity>>> getEtniasRepositoryDB() async {
    try {
      final result = await etniaLocalDataSource.getEtnias();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveEtniaRepositoryDB(EtniaEntity etnia) async {
    try {
      final result = await etniaLocalDataSource.saveEtnia(etnia);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
