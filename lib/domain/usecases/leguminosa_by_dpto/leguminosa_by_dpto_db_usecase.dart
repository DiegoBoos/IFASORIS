import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/leguminosa_entity.dart';
import '../../repositories/leguminosa_by_dpto/leguminosa_by_dpto_repository_db.dart';

class LeguminosaByDptoUsecaseDB {
  final LeguminosaByDptoRepositoryDB repositoryDB;

  LeguminosaByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveLeguminosaByDptoUsecaseDB(
      LeguminosaEntity leguminosa) {
    return repositoryDB.saveLeguminosaByDptoRepositoryDB(leguminosa);
  }

  Future<Either<Failure, List<LeguminosaEntity>>>
      getLeguminosasByDptoUsecaseDB() {
    return repositoryDB.getLeguminosasByDptoRepositoryDB();
  }
}
