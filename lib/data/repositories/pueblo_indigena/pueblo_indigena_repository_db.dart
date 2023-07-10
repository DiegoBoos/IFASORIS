import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/pueblo_indigena_entity.dart';
import '../../../domain/repositories/pueblo_indigena/pueblo_indigena_repository_db.dart';
import '../../datasources/local/pueblo_indigena_local_ds.dart';

class PuebloIndigenaRepositoryDBImpl implements PuebloIndigenaRepositoryDB {
  final PuebloIndigenaLocalDataSource puebloIndigenaLocalDataSource;

  PuebloIndigenaRepositoryDBImpl({required this.puebloIndigenaLocalDataSource});

  @override
  Future<Either<Failure, List<PuebloIndigenaEntity>>>
      getPueblosIndigenasRepositoryDB() async {
    try {
      final result = await puebloIndigenaLocalDataSource.getPueblosIndigenas();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePuebloIndigenaRepositoryDB(
      PuebloIndigenaEntity puebloIndigena) async {
    try {
      final result = await puebloIndigenaLocalDataSource
          .savePuebloIndigena(puebloIndigena);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
