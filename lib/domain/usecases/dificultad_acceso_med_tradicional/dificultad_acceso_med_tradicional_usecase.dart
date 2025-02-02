import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/dificultad_acceso_med_tradicional.dart';
import '../../repositories/dificultad_acceso_med_tradicional/dificultad_acceso_med_tradicional_repository.dart';

class DificultadAccesoMedTradicionalUsecase {
  final DificultadAccesoMedTradicionalRepository repository;

  DificultadAccesoMedTradicionalUsecase(this.repository);

  Future<Either<Failure, List<DificultadAccesoMedTradicionalEntity>>>
      getDificultadesAccesoMedTradicionalUsecase(int dtoId) {
    return repository.getDificultadesAccesoMedTradicionalRepository(dtoId);
  }
}
