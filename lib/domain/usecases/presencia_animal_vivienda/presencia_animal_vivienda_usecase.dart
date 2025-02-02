import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/presencia_animal_vivienda.dart';
import '../../repositories/presencia_animal_vivienda/presencia_animal_vivienda_repository.dart';

class PresenciaAnimalViviendaUsecase {
  final PresenciaAnimalViviendaRepository repository;

  PresenciaAnimalViviendaUsecase(this.repository);

  Future<Either<Failure, List<PresenciaAnimalViviendaEntity>>>
      getPresenciaAnimalesViviendaUsecase(int dtoId) {
    return repository.getPresenciaAnimalesViviendaRepository(dtoId);
  }
}
