import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/lugar_vacunacion_entity.dart';
import '../../repositories/lugar_vacunacion/lugar_vacunacion_repository_db.dart';

class LugarVacunacionUsecaseDB {
  final LugarVacunacionRepositoryDB repositoryDB;

  LugarVacunacionUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveLugarVacunacionUsecaseDB(
      LugarVacunacionEntity lugarVacunacion) {
    return repositoryDB.saveLugarVacunacionRepositoryDB(lugarVacunacion);
  }

  Future<Either<Failure, List<LugarVacunacionEntity>>>
      getLugaresVacunacionUsecaseDB() {
    return repositoryDB.getLugaresVacunacionRepositoryDB();
  }
}
