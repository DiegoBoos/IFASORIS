import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/etnia_entity.dart';
import '../../repositories/etnia/etnia_repository_db.dart';

class EtniaUsecaseDB {
  final EtniaRepositoryDB repositoryDB;

  EtniaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveEtniaUsecaseDB(EtniaEntity etnia) {
    return repositoryDB.saveEtniaRepositoryDB(etnia);
  }

  Future<Either<Failure, List<EtniaEntity>>> getEtniasUsecaseDB() {
    return repositoryDB.getEtniasRepositoryDB();
  }
}
