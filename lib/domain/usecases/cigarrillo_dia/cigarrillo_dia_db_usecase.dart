import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/cigarrillo_dia.dart';
import '../../repositories/cigarrillo_dia/cigarrillo_dia_repository_db.dart';

class CigarrilloDiaUsecaseDB {
  final CigarrilloDiaRepositoryDB repositoryDB;

  CigarrilloDiaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveCigarrilloDiaUsecaseDB(
      CigarrilloDiaEntity cigarrilloDia) {
    return repositoryDB.saveCigarrilloDiaRepositoryDB(cigarrilloDia);
  }

  Future<Either<Failure, List<CigarrilloDiaEntity>>>
      getCigarrillosDiaUsecaseDB() {
    return repositoryDB.getCigarrillosDiaRepositoryDB();
  }
}
