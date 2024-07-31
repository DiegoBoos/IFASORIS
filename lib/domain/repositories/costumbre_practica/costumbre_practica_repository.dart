import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/costumbre_practica.dart';

abstract class CostumbrePracticaRepository {
  Future<Either<Failure, List<CostumbrePracticaEntity>>>
      getCostumbresPracticanRepository(int dtoId);
}
