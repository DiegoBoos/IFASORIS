import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/presencia_animal_vivienda_entity.dart';

abstract class PresenciaAnimalViviendaByDptoRepositoryDB {
  Future<Either<Failure, int>> savePresenciaAnimalViviendaByDptoRepositoryDB(
      PresenciaAnimalViviendaEntity presenciaAnimalVivienda);

  Future<Either<Failure, List<PresenciaAnimalViviendaEntity>>>
      getPresenciaAnimalesViviendaByDptoRepositoryDB();
}
