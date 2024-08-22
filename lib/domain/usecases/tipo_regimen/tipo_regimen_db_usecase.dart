import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_regimen.dart';
import '../../repositories/tipo_regimen/tipo_regimen_repository_db.dart';

class TipoRegimenUsecaseDB {
  final TipoRegimenRepositoryDB repositoryDB;

  TipoRegimenUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveTipoRegimenUsecaseDB(
      TipoRegimenEntity tiporegimen) {
    return repositoryDB.saveTipoRegimenRepositoryDB(tiporegimen);
  }

  Future<Either<Failure, List<TipoRegimenEntity>>> getTipoRegimenesUsecaseDB() {
    return repositoryDB.getTipoRegimenesRepositoryDB();
  }
}
