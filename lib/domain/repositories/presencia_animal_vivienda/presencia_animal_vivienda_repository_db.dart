import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../data/models/presencia_animal_vivienda.dart';
import '../../entities/presencia_animal_vivienda.dart';

abstract class PresenciaAnimalViviendaRepositoryDB {
  Future<Either<Failure, int>> savePresenciaAnimalViviendaRepositoryDB(
      PresenciaAnimalViviendaEntity presenciaAnimalVivienda);

  Future<Either<Failure, List<PresenciaAnimalViviendaEntity>>>
      getPresenciaAnimalesRepositoryDB();

  Future<Either<Failure, List<LstPresenciaAnimal>>>
      getPresenciaAnimalesViviendaRepositoryDB(int? datoViviendaId);

  Future<Either<Failure, int>> savePresenciaAnimalesViviendaRepositoryDB(
      int datoViviendaId, List<LstPresenciaAnimal> lstPresenciaAnimal);
}
