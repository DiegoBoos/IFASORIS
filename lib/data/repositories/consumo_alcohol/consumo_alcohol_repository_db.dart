import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/consumo_alcohol.dart';
import '../../../domain/repositories/consumo_alcohol/consumo_alcohol_repository_db.dart';
import '../../datasources/local/consumo_alcohol_local_ds.dart';
import '../../models/consumo_alcohol.dart';

class ConsumoAlcoholRepositoryDBImpl implements ConsumoAlcoholRepositoryDB {
  final ConsumoAlcoholLocalDataSource consumoAlcoholLocalDataSource;

  ConsumoAlcoholRepositoryDBImpl({required this.consumoAlcoholLocalDataSource});

  @override
  Future<Either<Failure, List<ConsumoAlcoholModel>>>
      getConsumosAlcoholRepositoryDB() async {
    try {
      final result = await consumoAlcoholLocalDataSource.getConsumosAlcohol();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveConsumoAlcoholRepositoryDB(
      ConsumoAlcoholEntity consumoAlcohol) async {
    try {
      final consumoAlcoholModel =
          ConsumoAlcoholModel.fromEntity(consumoAlcohol);
      final result = await consumoAlcoholLocalDataSource
          .saveConsumoAlcohol(consumoAlcoholModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
