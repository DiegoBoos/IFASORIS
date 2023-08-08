import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/especie_animal_entity.dart';
import '../../repositories/especie_animal/especie_animal_repository.dart';

class EspecieAnimalUsecase {
  final EspecieAnimalRepository repository;

  EspecieAnimalUsecase(this.repository);

  Future<Either<Failure, List<EspecieAnimalEntity>>> getEspeciesAnimalesUsecase(
      int dtoId) {
    return repository.getEspeciesAnimalesRepository(dtoId);
  }
}
