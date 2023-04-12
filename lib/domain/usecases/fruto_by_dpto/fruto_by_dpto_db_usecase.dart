import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/fruto_entity.dart';
import '../../repositories/fruto_by_dpto/fruto_by_dpto_repository_db.dart';

class FrutoByDptoUsecaseDB {
  final FrutoByDptoRepositoryDB repositoryDB;

  FrutoByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveFrutoByDptoUsecaseDB(FrutoEntity fruto) {
    return repositoryDB.saveFrutoByDptoRepositoryDB(fruto);
  }

  Future<Either<Failure, List<FrutoEntity>>> getFrutosByDptoUsecaseDB() {
    return repositoryDB.getFrutosByDptoRepositoryDB();
  }
}
