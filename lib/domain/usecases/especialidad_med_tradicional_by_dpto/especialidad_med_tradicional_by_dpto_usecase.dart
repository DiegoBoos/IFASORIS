import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/especialidad_med_tradicional_by_dpto_entity.dart';
import '../../repositories/especialidad_med_tradicional_by_dpto/especialidad_med_tradicional_by_dpto_repository.dart';

class EspecialidadMedTradicionalByDptoUsecase {
  final EspecialidadMedTradicionalByDptoRepository repository;

  EspecialidadMedTradicionalByDptoUsecase(this.repository);

  Future<Either<Failure, List<EspecialidadMedTradicionalByDptoEntity>>>
      getEspecialidadesMedTradicionalByDptoUsecase(int dtoId) {
    return repository.getEspecialidadesMedTradicionalByDptoRepository(dtoId);
  }
}
