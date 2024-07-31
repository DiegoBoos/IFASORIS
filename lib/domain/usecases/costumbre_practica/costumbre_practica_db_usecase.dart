import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/costumbre_practica.dart';
import '../../repositories/costumbre_practica/costumbre_practica_repository_db.dart';

class CostumbrePracticaUsecaseDB {
  final CostumbrePracticaRepositoryDB repositoryDB;

  CostumbrePracticaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveCostumbrePracticaUsecaseDB(
      CostumbrePracticaEntity costumbrePractica) {
    return repositoryDB.saveCostumbrePracticaRepositoryDB(costumbrePractica);
  }

  Future<Either<Failure, List<CostumbrePracticaEntity>>>
      getCostumbresPracticanUsecaseDB() {
    return repositoryDB.getCostumbresPracticanRepositoryDB();
  }
}
