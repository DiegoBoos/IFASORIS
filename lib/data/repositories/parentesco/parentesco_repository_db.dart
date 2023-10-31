import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/parentesco_entity.dart';
import '../../../domain/repositories/parentesco/parentesco_repository_db.dart';
import '../../datasources/local/parentesco_local_ds.dart';

class ParentescoRepositoryDBImpl implements ParentescoRepositoryDB {
  final ParentescoLocalDataSource parentescoLocalDataSource;

  ParentescoRepositoryDBImpl({required this.parentescoLocalDataSource});

  @override
  Future<Either<Failure, List<ParentescoEntity>>>
      getParentescosRepositoryDB() async {
    try {
      final result = await parentescoLocalDataSource.getParentescos();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveParentescoRepositoryDB(
      ParentescoEntity parentesco) async {
    try {
      final result = await parentescoLocalDataSource.saveParentesco(parentesco);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
