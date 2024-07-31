import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/especie_animal.dart';

import '../../../core/error/failure.dart';
import '../../entities/especie_animal.dart';

abstract class EspecieAnimalRepositoryDB {
  Future<Either<Failure, int>> saveEspecieAnimalRepositoryDB(
      EspecieAnimalEntity especieAnimal);

  Future<Either<Failure, List<EspecieAnimalEntity>>>
      getEspeciesAnimalesRepositoryDB();

  Future<Either<Failure, int>> saveUbicacionEspecieAnimalesCriaRepositoryDB(
      int ubicacionId, List<LstAnimalCria> lstAnimalCria);

  Future<Either<Failure, List<LstAnimalCria>>>
      getUbicacionEspeciesAnimalesRepositoryDB(int? ubicacionId);
}
