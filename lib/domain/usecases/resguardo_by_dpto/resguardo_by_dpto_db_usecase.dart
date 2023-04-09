import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/resguardo_by_dpto_entity.dart';
import '../../repositories/resguardo_by_dpto/resguardo_by_dpto_repository_db.dart';

class ResguardoByDptoUsecaseDB {
  final ResguardoByDptoRepositoryDB repositoryDB;

  ResguardoByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveResguardoByDptoUsecaseDB(
      ResguardoByDptoEntity resguardoByDpto) {
    return repositoryDB.saveResguardoByDptoRepositoryDB(resguardoByDpto);
  }

  Future<Either<Failure, List<ResguardoByDptoEntity>>>
      getResguardosByDptoUsecaseDB(int dtoId) {
    return repositoryDB.getResguardosByDptoRepositoryDB(dtoId);
  }
}
