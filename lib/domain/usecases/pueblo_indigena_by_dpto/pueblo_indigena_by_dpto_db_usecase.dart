import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/pueblo_indigena_entity.dart';
import '../../repositories/pueblo_indigena_by_dpto/pueblo_indigena_by_dpto_repository_db.dart';

class PuebloIndigenaByDptoUsecaseDB {
  final PuebloIndigenaByDptoRepositoryDB repositoryDB;

  PuebloIndigenaByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> savePuebloIndigenaByDptoUsecaseDB(
      PuebloIndigenaEntity puebloIndigena) {
    return repositoryDB.savePuebloIndigenaByDptoRepositoryDB(puebloIndigena);
  }

  Future<Either<Failure, List<PuebloIndigenaEntity>>>
      getPueblosIndigenasByDptoUsecaseDB() {
    return repositoryDB.getPueblosIndigenasByDptoRepositoryDB();
  }
}
