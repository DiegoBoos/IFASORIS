import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/resguardo_entity.dart';
import '../../repositories/resguardo_by_dpto/resguardo_by_dpto_repository_db.dart';

class ResguardoByDptoUsecaseDB {
  final ResguardoByDptoRepositoryDB repositoryDB;

  ResguardoByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveResguardoByDptoUsecaseDB(
      ResguardoEntity resguardo) {
    return repositoryDB.saveResguardoByDptoRepositoryDB(resguardo);
  }

  Future<Either<Failure, List<ResguardoEntity>>>
      getResguardosByDptoUsecaseDB() {
    return repositoryDB.getResguardosByDptoRepositoryDB();
  }
}
