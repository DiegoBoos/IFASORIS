import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/presencia_animal_vivienda_entity.dart';

abstract class PresenciaAnimalViviendaByDptoRepository {
  Future<Either<Failure, List<PresenciaAnimalViviendaEntity>>>
      getPresenciaAnimalesViviendaByDptoRepository(int dtoId);
}
