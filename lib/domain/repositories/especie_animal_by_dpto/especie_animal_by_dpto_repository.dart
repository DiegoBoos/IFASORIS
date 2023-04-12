import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/especie_animal_entity.dart';

abstract class EspecieAnimalByDptoRepository {
  Future<Either<Failure, List<EspecieAnimalEntity>>>
      getEspeciesAnimalesByDptoRepository(int dtoId);
}
