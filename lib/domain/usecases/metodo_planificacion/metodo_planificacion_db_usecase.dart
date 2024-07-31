import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/metodo_planificacion.dart';
import '../../repositories/metodo_planificacion/metodo_planificacion_repository_db.dart';

class MetodoPlanificacionUsecaseDB {
  final MetodoPlanificacionRepositoryDB repositoryDB;

  MetodoPlanificacionUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveMetodoPlanificacionUsecaseDB(
      MetodoPlanificacionEntity metodoPlanificacion) {
    return repositoryDB
        .saveMetodoPlanificacionRepositoryDB(metodoPlanificacion);
  }

  Future<Either<Failure, List<MetodoPlanificacionEntity>>>
      getMetodosPlanificacionUsecaseDB() {
    return repositoryDB.getMetodosPlanificacionRepositoryDB();
  }
}
