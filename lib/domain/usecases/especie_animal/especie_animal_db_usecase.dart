import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/especie_animal.dart';

import '../../../core/error/failure.dart';
import '../../entities/especie_animal.dart';
import '../../repositories/especie_animal/especie_animal_repository_db.dart';

class EspecieAnimalUsecaseDB {
  final EspecieAnimalRepositoryDB repositoryDB;

  EspecieAnimalUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveEspecieAnimalUsecaseDB(
      EspecieAnimalEntity especieAnimal) {
    return repositoryDB.saveEspecieAnimalRepositoryDB(especieAnimal);
  }

  Future<Either<Failure, List<EspecieAnimalEntity>>>
      getEspeciesAnimalesUsecaseDB() {
    return repositoryDB.getEspeciesAnimalesRepositoryDB();
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
