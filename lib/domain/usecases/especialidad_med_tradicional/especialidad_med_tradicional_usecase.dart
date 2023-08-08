import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/especialidad_med_tradicional_entity.dart';
import '../../repositories/especialidad_med_tradicional/especialidad_med_tradicional_repository.dart';

class EspecialidadMedTradicionalUsecase {
  final EspecialidadMedTradicionalRepository repository;

  EspecialidadMedTradicionalUsecase(this.repository);

  Future<Either<Failure, List<EspecialidadMedTradicionalEntity>>>
      getEspecialidadesMedTradicionalUsecase(int dtoId) {
    return repository.getEspecialidadesMedTradicionalRepository(dtoId);
  }
}
