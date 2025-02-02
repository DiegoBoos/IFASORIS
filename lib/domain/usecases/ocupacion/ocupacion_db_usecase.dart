import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/ocupacion.dart';
import '../../repositories/ocupacion/ocupacion_repository_db.dart';

class OcupacionUsecaseDB {
  final OcupacionRepositoryDB repositoryDB;

  OcupacionUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveOcupacionUsecaseDB(
      OcupacionEntity ocupacion) {
    return repositoryDB.saveOcupacionRepositoryDB(ocupacion);
  }

  Future<Either<Failure, List<OcupacionEntity>>> getOcupacionesUsecaseDB() {
    return repositoryDB.getOcupacionesRepositoryDB();
  }
}
