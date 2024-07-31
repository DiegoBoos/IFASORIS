import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/presencia_animal_vivienda.dart';

abstract class PresenciaAnimalViviendaRepository {
  Future<Either<Failure, List<PresenciaAnimalViviendaEntity>>>
      getPresenciaAnimalesViviendaRepository(int dtoId);
}
