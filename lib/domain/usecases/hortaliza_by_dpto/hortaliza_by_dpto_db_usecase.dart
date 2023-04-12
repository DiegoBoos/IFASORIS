import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/hortaliza_entity.dart';
import '../../repositories/hortaliza_by_dpto/hortaliza_by_dpto_repository_db.dart';

class HortalizaByDptoUsecaseDB {
  final HortalizaByDptoRepositoryDB repositoryDB;

  HortalizaByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveHortalizaByDptoUsecaseDB(
      HortalizaEntity hortaliza) {
    return repositoryDB.saveHortalizaByDptoRepositoryDB(hortaliza);
  }

  Future<Either<Failure, List<HortalizaEntity>>>
      getHortalizasByDptoUsecaseDB() {
    return repositoryDB.getHortalizasByDptoRepositoryDB();
  }
}
