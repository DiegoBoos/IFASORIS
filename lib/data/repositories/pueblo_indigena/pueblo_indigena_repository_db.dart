import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/pueblo_indigena.dart';
import '../../../domain/repositories/pueblo_indigena/pueblo_indigena_repository_db.dart';
import '../../datasources/local/pueblo_indigena_local_ds.dart';
import '../../models/pueblo_indigena.dart';

class PuebloIndigenaRepositoryDBImpl implements PuebloIndigenaRepositoryDB {
  final PuebloIndigenaLocalDataSource puebloIndigenaLocalDataSource;

  PuebloIndigenaRepositoryDBImpl({required this.puebloIndigenaLocalDataSource});

  @override
  Future<Either<Failure, List<PuebloIndigenaModel>>>
      getPueblosIndigenasRepositoryDB() async {
    try {
      final result = await puebloIndigenaLocalDataSource.getPueblosIndigenas();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> savePuebloIndigenaRepositoryDB(
      PuebloIndigenaEntity puebloIndigena) async {
    try {
      final puebloIndigenaModel =
          PuebloIndigenaModel.fromEntity(puebloIndigena);
      final result = await puebloIndigenaLocalDataSource
          .savePuebloIndigena(puebloIndigenaModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
