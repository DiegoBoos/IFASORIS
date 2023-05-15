import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/presencia_animal_vivienda_entity.dart';
import '../../repositories/presencia_animal_vivienda_by_dpto/presencia_animal_vivienda_by_dpto_repository.dart';

class PresenciaAnimalViviendaByDptoUsecase {
  final PresenciaAnimalViviendaByDptoRepository repository;

  PresenciaAnimalViviendaByDptoUsecase(this.repository);

  Future<Either<Failure, List<PresenciaAnimalViviendaEntity>>>
      getPresenciaAnimalesViviendaByDptoUsecase(int dtoId) {
    return repository.getPresenciaAnimalesViviendaByDptoRepository(dtoId);
  }
}
