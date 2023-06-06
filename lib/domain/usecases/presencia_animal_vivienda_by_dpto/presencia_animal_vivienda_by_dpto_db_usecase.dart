import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../data/models/presencia_animal_vivienda_model.dart';
import '../../entities/presencia_animal_vivienda_entity.dart';
import '../../repositories/presencia_animal_vivienda_by_dpto/presencia_animal_vivienda_by_dpto_repository_db.dart';

class PresenciaAnimalViviendaByDptoUsecaseDB {
  final PresenciaAnimalViviendaByDptoRepositoryDB repositoryDB;

  PresenciaAnimalViviendaByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> savePresenciaAnimalViviendaByDptoUsecaseDB(
      PresenciaAnimalViviendaEntity presenciaAnimalViviendaByDpto) {
    return repositoryDB.savePresenciaAnimalViviendaByDptoRepositoryDB(
        presenciaAnimalViviendaByDpto);
  }

  Future<Either<Failure, List<PresenciaAnimalViviendaEntity>>>
      getPresenciaAnimalesViviendaByDptoUsecaseDB() {
    return repositoryDB.getPresenciaAnimalesViviendaByDptoRepositoryDB();
  }

  Future<Either<Failure, List<LstPresenciaAnimal>>>
      getPresenciaAnimalesViviendaUsecaseDB(int? datoViviendaId) {
    return repositoryDB
        .getPresenciaAnimalesViviendaRepositoryDB(datoViviendaId);
  }

  Future<Either<Failure, int>> savePresenciaAnimalesViviendaUsecaseDB(
      int datoViviendaId, List<LstPresenciaAnimal> lstPresenciaAnimales) {
    return repositoryDB.savePresenciaAnimalesViviendaRepositoryDB(
        datoViviendaId, lstPresenciaAnimales);
  }
}
