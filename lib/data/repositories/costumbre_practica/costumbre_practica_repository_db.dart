import 'package:dartz/dartz.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/costumbre_practica.dart';
import '../../../domain/repositories/costumbre_practica/costumbre_practica_repository_db.dart';
import '../../datasources/local/costumbre_practica_local_ds.dart';
import '../../models/costumbre_practica.dart';

class CostumbrePracticaRepositoryDBImpl
    implements CostumbrePracticaRepositoryDB {
  final CostumbrePracticaLocalDataSource costumbrePracticaLocalDataSource;

  CostumbrePracticaRepositoryDBImpl(
      {required this.costumbrePracticaLocalDataSource});

  @override
  Future<Either<Failure, List<CostumbrePracticaModel>>>
      getCostumbresPracticanRepositoryDB() async {
    try {
      final result =
          await costumbrePracticaLocalDataSource.getCostumbresPractica();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveCostumbrePracticaRepositoryDB(
      CostumbrePracticaEntity costumbrePractica) async {
    try {
      final costumbrePracticaModel =
          CostumbrePracticaModel.fromEntity(costumbrePractica);
      final result = await costumbrePracticaLocalDataSource
          .saveCostumbrePractica(costumbrePracticaModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
