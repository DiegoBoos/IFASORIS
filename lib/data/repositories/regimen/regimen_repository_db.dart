import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/regimen_entity.dart';
import '../../../domain/repositories/regimen/regimen_repository_db.dart';
import '../../datasources/local/regimen_local_ds.dart';

class RegimenRepositoryDBImpl implements RegimenRepositoryDB {
  final RegimenLocalDataSource regimenLocalDataSource;

  RegimenRepositoryDBImpl({required this.regimenLocalDataSource});

  @override
  Future<Either<Failure, List<RegimenEntity>>>
      getRegimenesRepositoryDB() async {
    try {
      final result = await regimenLocalDataSource.getRegimenes();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveRegimenRepositoryDB(
      RegimenEntity regimen) async {
    try {
      final result = await regimenLocalDataSource.saveRegimen(regimen);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
