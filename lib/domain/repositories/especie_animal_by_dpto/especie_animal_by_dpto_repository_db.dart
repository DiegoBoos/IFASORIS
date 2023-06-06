import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/especie_animal_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/especie_animal_entity.dart';

abstract class EspecieAnimalByDptoRepositoryDB {
  Future<Either<Failure, int>> saveEspecieAnimalByDptoRepositoryDB(
      EspecieAnimalEntity especieAnimal);

  Future<Either<Failure, List<EspecieAnimalEntity>>>
      getEspeciesAnimalesByDptoRepositoryDB();

  Future<Either<Failure, int>> saveUbicacionEspecieAnimalesCriaRepositoryDB(
      int ubicacionId, List<LstAnimalCria> lstAnimalCria);

  Future<Either<Failure, List<LstAnimalCria>>>
      getUbicacionEspeciesAnimalesRepositoryDB(int? ubicacionId);
}
