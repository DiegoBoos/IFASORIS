import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../data/models/presencia_animal_vivienda_model.dart';
import '../../entities/presencia_animal_vivienda_entity.dart';
import '../../repositories/presencia_animal_vivienda/presencia_animal_vivienda_repository_db.dart';

class PresenciaAnimalViviendaUsecaseDB {
  final PresenciaAnimalViviendaRepositoryDB repositoryDB;

  PresenciaAnimalViviendaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> savePresenciaAnimalViviendaUsecaseDB(
      PresenciaAnimalViviendaEntity presenciaAnimalVivienda) {
    return repositoryDB
        .savePresenciaAnimalViviendaRepositoryDB(presenciaAnimalVivienda);
  }

  Future<Either<Failure, List<PresenciaAnimalViviendaEntity>>>
      getPresenciaAnimalesUsecaseDB() {
    return repositoryDB.getPresenciaAnimalesRepositoryDB();
  }

  Future<Either<Failure, List<LstPresenciaAnimal>>>
      getPresenciaAnimalesViviendaUsecaseDB(int? datoViviendaId) {
    return repositoryDB
        .getPresenciaAnimalesViviendaRepositoryDB(datoViviendaId);
  }

  Future<Either<Failure, int>> savePresenciaAnimalesViviendaUsecaseDB(
      int datoViviendaId, List<LstPresenciaAnimal> lstPresenciaAnimal) {
    return repositoryDB.savePresenciaAnimalesViviendaRepositoryDB(
        datoViviendaId, lstPresenciaAnimal);
  }
}
