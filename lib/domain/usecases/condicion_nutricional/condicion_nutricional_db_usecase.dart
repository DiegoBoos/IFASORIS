import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/condicion_nutricional.dart';
import '../../repositories/condicion_nutricional/condicion_nutricional_repository_db.dart';

class CondicionNutricionalUsecaseDB {
  final CondicionNutricionalRepositoryDB repositoryDB;

  CondicionNutricionalUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveCondicionNutricionalUsecaseDB(
      CondicionNutricionalEntity condicionNutricional) {
    return repositoryDB
        .saveCondicionNutricionalRepositoryDB(condicionNutricional);
  }

  Future<Either<Failure, List<CondicionNutricionalEntity>>>
      getCondicionesNutricionalesUsecaseDB() {
    return repositoryDB.getCondicionesNutricionalesRepositoryDB();
  }
}
