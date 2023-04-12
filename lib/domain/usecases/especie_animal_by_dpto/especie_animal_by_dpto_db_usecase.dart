import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/especie_animal_entity.dart';
import '../../repositories/especie_animal_by_dpto/especie_animal_by_dpto_repository_db.dart';

class EspecieAnimalByDptoUsecaseDB {
  final EspecieAnimalByDptoRepositoryDB repositoryDB;

  EspecieAnimalByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveEspecieAnimalByDptoUsecaseDB(
      EspecieAnimalEntity especieAnimal) {
    return repositoryDB.saveEspecieAnimalByDptoRepositoryDB(especieAnimal);
  }

  Future<Either<Failure, List<EspecieAnimalEntity>>>
      getEspeciesAnimalesByDptoUsecaseDB() {
    return repositoryDB.getEspeciesAnimalesByDptoRepositoryDB();
  }
}
