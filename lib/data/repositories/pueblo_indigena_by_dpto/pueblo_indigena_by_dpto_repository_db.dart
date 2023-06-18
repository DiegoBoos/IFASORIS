import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/pueblo_indigena_entity.dart';
import '../../../domain/repositories/pueblo_indigena_by_dpto/pueblo_indigena_by_dpto_repository_db.dart';
import '../../datasources/local/pueblo_indigena_by_dpto_local_ds.dart';

class PuebloIndigenaByDptoRepositoryDBImpl
    implements PuebloIndigenaByDptoRepositoryDB {
  final PuebloIndigenaByDptoLocalDataSource puebloIndigenaByDptoLocalDataSource;

  PuebloIndigenaByDptoRepositoryDBImpl(
      {required this.puebloIndigenaByDptoLocalDataSource});

  @override
  Future<Either<Failure, List<PuebloIndigenaEntity>>>
      getPueblosIndigenasByDptoRepositoryDB() async {
    try {
      final result =
          await puebloIndigenaByDptoLocalDataSource.getPueblosIndigenasByDpto();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePuebloIndigenaByDptoRepositoryDB(
      PuebloIndigenaEntity puebloIndigena) async {
    try {
      final result = await puebloIndigenaByDptoLocalDataSource
          .savePuebloIndigenaByDpto(puebloIndigena);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
