import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/conducta_seguir.dart';
import '../../repositories/conducta_seguir/conducta_seguir_repository_db.dart';

class ConductaSeguirUsecaseDB {
  final ConductaSeguirRepositoryDB repositoryDB;

  ConductaSeguirUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveConductaSeguirUsecaseDB(
      ConductaSeguirEntity conductaSeguir) {
    return repositoryDB.saveConductaSeguirRepositoryDB(conductaSeguir);
  }

  Future<Either<Failure, List<ConductaSeguirEntity>>>
      getConductasSeguirUsecaseDB() {
    return repositoryDB.getConductasSeguirRepositoryDB();
  }
}
