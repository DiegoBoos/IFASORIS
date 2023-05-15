import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
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
}
