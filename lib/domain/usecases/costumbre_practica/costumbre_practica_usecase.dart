import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/costumbre_practica_entity.dart';
import '../../repositories/costumbre_practica/costumbre_practica_repository.dart';

class CostumbrePracticaUsecase {
  final CostumbrePracticaRepository repository;

  CostumbrePracticaUsecase(this.repository);

  Future<Either<Failure, List<CostumbrePracticaEntity>>>
      getCostumbresPracticanUsecase(int dtoId) {
    return repository.getCostumbresPracticanRepository(dtoId);
  }
}
