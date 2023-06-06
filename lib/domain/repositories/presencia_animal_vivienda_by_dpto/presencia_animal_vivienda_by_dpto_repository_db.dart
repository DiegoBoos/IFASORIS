import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../data/models/presencia_animal_vivienda_model.dart';
import '../../entities/presencia_animal_vivienda_entity.dart';

abstract class PresenciaAnimalViviendaByDptoRepositoryDB {
  Future<Either<Failure, int>> savePresenciaAnimalViviendaByDptoRepositoryDB(
      PresenciaAnimalViviendaEntity presenciaAnimalVivienda);

  Future<Either<Failure, List<PresenciaAnimalViviendaEntity>>>
      getPresenciaAnimalesViviendaByDptoRepositoryDB();

  Future<Either<Failure, List<LstPresenciaAnimal>>>
      getPresenciaAnimalesViviendaRepositoryDB(int? datoViviendaId);

  Future<Either<Failure, int>> savePresenciaAnimalesViviendaRepositoryDB(
      int datoViviendaId, List<LstPresenciaAnimal> lstPresenciaAnimales);
}
