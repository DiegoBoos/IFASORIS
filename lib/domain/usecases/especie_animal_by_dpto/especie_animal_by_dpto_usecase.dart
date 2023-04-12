import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/especie_animal_entity.dart';
import '../../repositories/especie_animal_by_dpto/especie_animal_by_dpto_repository.dart';

class EspecieAnimalByDptoUsecase {
  final EspecieAnimalByDptoRepository repository;

  EspecieAnimalByDptoUsecase(this.repository);

  Future<Either<Failure, List<EspecieAnimalEntity>>>
      getEspeciesAnimalesByDptoUsecase(int dtoId) {
    return repository.getEspeciesAnimalesByDptoRepository(dtoId);
  }
}
