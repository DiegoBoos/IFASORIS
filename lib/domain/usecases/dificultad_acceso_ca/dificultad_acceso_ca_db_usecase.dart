import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/dificultad_acceso_ca_entity.dart';
import '../../repositories/dificultad_acceso_ca/dificultad_acceso_ca_repository_db.dart';

class DificultadAccesoCAUsecaseDB {
  final DificultadAccesoCARepositoryDB repositoryDB;

  DificultadAccesoCAUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveDificultadAccesoCAUsecase(
      DificultadAccesoCAEntity dificultadAccesoCA) {
    return repositoryDB.saveDificultadAccesoCARepositoryDB(dificultadAccesoCA);
  }

  Future<Either<Failure, List<DificultadAccesoCAEntity>>>
      getDificultadesAccesoCAUsecase() {
    return repositoryDB.getDificultadesAccesoCARepositoryDB();
  }
}
