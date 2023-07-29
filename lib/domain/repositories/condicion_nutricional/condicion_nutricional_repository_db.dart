import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/condicion_nutricional_entity.dart';

abstract class CondicionNutricionalRepositoryDB {
  Future<Either<Failure, int>> saveCondicionNutricionalRepositoryDB(
      CondicionNutricionalEntity condicionNutricional);

  Future<Either<Failure, List<CondicionNutricionalEntity>>>
      getCondicionesNutricionalesRepositoryDB();
}
