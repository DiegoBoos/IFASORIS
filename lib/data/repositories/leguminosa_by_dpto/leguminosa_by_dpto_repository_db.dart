import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/leguminosa_entity.dart';
import '../../../domain/repositories/leguminosa_by_dpto/leguminosa_by_dpto_repository_db.dart';
import '../../datasources/local/leguminosa_by_dpto_local_ds.dart';

class LeguminosaByDptoRepositoryDBImpl implements LeguminosaByDptoRepositoryDB {
  final LeguminosaByDptoLocalDataSource leguminosaByDptoLocalDataSource;

  LeguminosaByDptoRepositoryDBImpl(
      {required this.leguminosaByDptoLocalDataSource});

  @override
  Future<Either<Failure, List<LeguminosaEntity>>>
      getLeguminosasByDptoRepositoryDB() async {
    try {
      final result =
          await leguminosaByDptoLocalDataSource.getLeguminosasByDpto();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveLeguminosaByDptoRepositoryDB(
      LeguminosaEntity leguminosa) async {
    try {
      final result = await leguminosaByDptoLocalDataSource
          .saveLeguminosaByDpto(leguminosa);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
