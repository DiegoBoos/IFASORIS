import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/verdura_entity.dart';
import '../../../domain/repositories/verdura_by_dpto/verdura_by_dpto_repository_db.dart';
import '../../datasources/local/verdura_by_dpto_local_ds.dart';

class VerduraByDptoRepositoryDBImpl implements VerduraByDptoRepositoryDB {
  final VerduraByDptoLocalDataSource verduraByDptoLocalDataSource;

  VerduraByDptoRepositoryDBImpl({required this.verduraByDptoLocalDataSource});

  @override
  Future<Either<Failure, List<VerduraEntity>>>
      getVerdurasByDptoRepositoryDB() async {
    try {
      final result = await verduraByDptoLocalDataSource.getVerdurasByDpto();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveVerduraByDptoRepositoryDB(
      VerduraEntity verdura) async {
    try {
      final result =
          await verduraByDptoLocalDataSource.saveVerduraByDpto(verdura);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
