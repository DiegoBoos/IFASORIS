import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/dificultad_acceso_med_tradicional_entity.dart';
import '../../repositories/dificultad_acceso_med_tradicional_by_dpto/dificultad_acceso_med_tradicional_by_dpto_repository.dart';

class DificultadAccesoMedTradicionalByDptoUsecase {
  final DificultadAccesoMedTradicionalByDptoRepository repository;

  DificultadAccesoMedTradicionalByDptoUsecase(this.repository);

  Future<Either<Failure, List<DificultadAccesoMedTradicionalEntity>>>
      getDificultadesAccesoMedTradicionalByDptoUsecase(int dtoId) {
    return repository
        .getDificultadesAccesoMedTradicionalByDptoRepository(dtoId);
  }
}
