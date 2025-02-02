import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/costumbre_practica.dart';

abstract class CostumbrePracticaRepositoryDB {
  Future<Either<Failure, int>> saveCostumbrePracticaRepositoryDB(
      CostumbrePracticaEntity costumbrePractica);

  Future<Either<Failure, List<CostumbrePracticaEntity>>>
      getCostumbresPracticanRepositoryDB();
}
