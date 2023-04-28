import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/familia_entity.dart';
import '../../../domain/repositories/familia/familia_repository_db.dart';
import '../../datasources/local/familia_local_ds.dart';

class FamiliaRepositoryDBImpl implements FamiliaRepositoryDB {
  final FamiliaLocalDataSource familiaLocalDataSource;

  FamiliaRepositoryDBImpl({required this.familiaLocalDataSource});

  @override
  Future<Either<Failure, FamiliaEntity>> createFamiliaRepositoryDB(
      FamiliaEntity familia) async {
    try {
      final result = await familiaLocalDataSource.createFamilia(familia);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<FamiliaEntity>>>
      loadFamiliasRepositoryDB() async {
    try {
      final result = await familiaLocalDataSource.loadFamilias();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
