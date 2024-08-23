import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/parentesco.dart';
import '../../../domain/repositories/parentesco/parentesco_repository_db.dart';
import '../../datasources/local/parentesco_local_ds.dart';
import '../../models/parentesco.dart';

class ParentescoRepositoryDBImpl implements ParentescoRepositoryDB {
  final ParentescoLocalDataSource parentescoLocalDataSource;

  ParentescoRepositoryDBImpl({required this.parentescoLocalDataSource});

  @override
  Future<Either<Failure, List<ParentescoModel>>>
      getParentescosRepositoryDB() async {
    try {
      final result = await parentescoLocalDataSource.getParentescos();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveParentescoRepositoryDB(
      ParentescoEntity parentesco) async {
    try {
      final parentescoModel = ParentescoModel.fromEntity(parentesco);
      final result =
          await parentescoLocalDataSource.saveParentesco(parentescoModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
