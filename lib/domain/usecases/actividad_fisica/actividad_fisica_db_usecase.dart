import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/actividad_fisica_entity.dart';
import '../../repositories/actividad_fisica/actividad_fisica_repository_db.dart';

class ActividadFisicaUsecaseDB {
  final ActividadFisicaRepositoryDB repositoryDB;

  ActividadFisicaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveActividadFisicaUsecaseDB(
      ActividadFisicaEntity actividadFisica) {
    return repositoryDB.saveActividadFisicaRepositoryDB(actividadFisica);
  }

  Future<Either<Failure, List<ActividadFisicaEntity>>>
      getActividadesFisicasUsecaseDB() {
    return repositoryDB.getActividadesFisicasRepositoryDB();
  }
}
