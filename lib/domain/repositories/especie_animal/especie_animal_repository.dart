import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/especie_animal.dart';

abstract class EspecieAnimalRepository {
  Future<Either<Failure, List<EspecieAnimalEntity>>>
      getEspeciesAnimalesRepository(int dtoId);
}
