import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/consumo_alcohol.dart';
import '../../repositories/consumo_alcohol/consumo_alcohol_repository_db.dart';

class ConsumoAlcoholUsecaseDB {
  final ConsumoAlcoholRepositoryDB repositoryDB;

  ConsumoAlcoholUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveConsumoAlcoholUsecaseDB(
      ConsumoAlcoholEntity consumoAlcohol) {
    return repositoryDB.saveConsumoAlcoholRepositoryDB(consumoAlcohol);
  }

  Future<Either<Failure, List<ConsumoAlcoholEntity>>>
      getConsumosAlcoholUsecaseDB() {
    return repositoryDB.getConsumosAlcoholRepositoryDB();
  }
}
