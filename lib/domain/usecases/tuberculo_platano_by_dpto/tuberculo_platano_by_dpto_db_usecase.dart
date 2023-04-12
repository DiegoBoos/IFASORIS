import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tuberculo_platano_entity.dart';
import '../../repositories/tuberculo_platano_by_dpto/tuberculo_platano_by_dpto_repository_db.dart';

class TuberculoPlatanoByDptoUsecaseDB {
  final TuberculoPlatanoByDptoRepositoryDB repositoryDB;

  TuberculoPlatanoByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveTuberculoPlatanoByDptoUsecaseDB(
      TuberculoPlatanoEntity tuberculoPlatano) {
    return repositoryDB
        .saveTuberculoPlatanoByDptoRepositoryDB(tuberculoPlatano);
  }

  Future<Either<Failure, List<TuberculoPlatanoEntity>>>
      getTuberculosPlatanosByDptoUsecaseDB() {
    return repositoryDB.getTuberculosPlatanosByDptoRepositoryDB();
  }
}
