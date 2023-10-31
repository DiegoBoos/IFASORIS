import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/costumbre_practica_entity.dart';
import '../../../domain/repositories/costumbre_practica/costumbre_practica_repository_db.dart';
import '../../datasources/local/costumbre_practica_local_ds.dart';

class CostumbrePracticaRepositoryDBImpl
    implements CostumbrePracticaRepositoryDB {
  final CostumbrePracticaLocalDataSource costumbrePracticaLocalDataSource;

  CostumbrePracticaRepositoryDBImpl(
      {required this.costumbrePracticaLocalDataSource});

  @override
  Future<Either<Failure, List<CostumbrePracticaEntity>>>
      getCostumbresPracticanRepositoryDB() async {
    try {
      final result =
          await costumbrePracticaLocalDataSource.getCostumbresPractica();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveCostumbrePracticaRepositoryDB(
      CostumbrePracticaEntity costumbrePractica) async {
    try {
      final result = await costumbrePracticaLocalDataSource
          .saveCostumbrePractica(costumbrePractica);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
