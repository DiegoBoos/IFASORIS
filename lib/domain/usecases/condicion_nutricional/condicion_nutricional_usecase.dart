import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/condicion_nutricional.dart';
import '../../repositories/condicion_nutricional/condicion_nutricional_repository.dart';

class CondicionNutricionalUsecase {
  final CondicionNutricionalRepository repository;

  CondicionNutricionalUsecase(this.repository);

  Future<Either<Failure, List<CondicionNutricionalEntity>>>
      getCondicionesNutricionalesUsecase() {
    return repository.getCondicionesNutricionalesRepository();
  }
}
