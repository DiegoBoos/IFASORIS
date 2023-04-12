import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/especie_animal_entity.dart';

abstract class EspecieAnimalByDptoRepositoryDB {
  Future<Either<Failure, int>> saveEspecieAnimalByDptoRepositoryDB(
      EspecieAnimalEntity especieAnimal);

  Future<Either<Failure, List<EspecieAnimalEntity>>>
      getEspeciesAnimalesByDptoRepositoryDB();
}
