import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/alimentacion.dart';
import '../../repositories/alimentacion/alimentacion_repository_db.dart';

class AlimentacionUsecaseDB {
  final AlimentacionRepositoryDB repositoryDB;

  AlimentacionUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveAlimentacionUsecaseDB(
      AlimentacionEntity alimentacion) {
    return repositoryDB.saveAlimentacionRepositoryDB(alimentacion);
  }

  Future<Either<Failure, List<AlimentacionEntity>>>
      getAlimentacionesUsecaseDB() {
    return repositoryDB.getAlimentacionesRepositoryDB();
  }
}
