import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/condicion_nutricional.dart';

abstract class CondicionNutricionalRepository {
  Future<Either<Failure, List<CondicionNutricionalEntity>>>
      getCondicionesNutricionalesRepository();
}
