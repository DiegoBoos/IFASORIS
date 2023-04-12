import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/verdura_entity.dart';
import '../../repositories/verdura_by_dpto/verdura_by_dpto_repository_db.dart';

class VerduraByDptoUsecaseDB {
  final VerduraByDptoRepositoryDB repositoryDB;

  VerduraByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveVerduraByDptoUsecaseDB(
      VerduraEntity verdura) {
    return repositoryDB.saveVerduraByDptoRepositoryDB(verdura);
  }

  Future<Either<Failure, List<VerduraEntity>>> getVerdurasByDptoUsecaseDB() {
    return repositoryDB.getVerdurasByDptoRepositoryDB();
  }
}
