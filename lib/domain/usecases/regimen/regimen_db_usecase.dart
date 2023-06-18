import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/regimen_entity.dart';
import '../../repositories/regimen/regimen_repository_db.dart';

class RegimenUsecaseDB {
  final RegimenRepositoryDB repositoryDB;

  RegimenUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveRegimenUsecaseDB(RegimenEntity regimen) {
    return repositoryDB.saveRegimenRepositoryDB(regimen);
  }

  Future<Either<Failure, List<RegimenEntity>>> getRegimenesUsecaseDB() {
    return repositoryDB.getRegimenesRepositoryDB();
  }
}
