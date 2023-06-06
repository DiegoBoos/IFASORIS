import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/especie_animal_model.dart';

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

  Future<Either<Failure, int>> saveUbicacionEspecieAnimalesCriaUsecaseDB(
      int ubicacionId, List<LstAnimalCria> lstAnimalCria) {
    return repositoryDB.saveUbicacionEspecieAnimalesCriaRepositoryDB(
        ubicacionId, lstAnimalCria);
  }

  Future<Either<Failure, List<LstAnimalCria>>>
      getUbicacionEspeciesAnimalesUsecaseDB(int? ubicacionId) {
    return repositoryDB.getUbicacionEspeciesAnimalesRepositoryDB(ubicacionId);
  }
}
