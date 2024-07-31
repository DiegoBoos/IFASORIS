import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/pueblo_indigena.dart';
import '../../repositories/pueblo_indigena/pueblo_indigena_repository_db.dart';

class PuebloIndigenaUsecaseDB {
  final PuebloIndigenaRepositoryDB repositoryDB;

  PuebloIndigenaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> savePuebloIndigenaUsecaseDB(
      PuebloIndigenaEntity puebloIndigena) {
    return repositoryDB.savePuebloIndigenaRepositoryDB(puebloIndigena);
  }

  Future<Either<Failure, List<PuebloIndigenaEntity>>>
      getPueblosIndigenasUsecaseDB() {
    return repositoryDB.getPueblosIndigenasRepositoryDB();
  }
}
