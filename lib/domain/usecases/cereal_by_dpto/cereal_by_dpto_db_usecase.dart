import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/cereal_entity.dart';
import '../../repositories/cereal_by_dpto/cereal_by_dpto_repository_db.dart';

class CerealByDptoUsecaseDB {
  final CerealByDptoRepositoryDB repositoryDB;

  CerealByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveCerealByDptoUsecaseDB(CerealEntity cereal) {
    return repositoryDB.saveCerealByDptoRepositoryDB(cereal);
  }

  Future<Either<Failure, List<CerealEntity>>> getCerealesByDptoUsecaseDB() {
    return repositoryDB.getCerealesByDptoRepositoryDB();
  }
}
