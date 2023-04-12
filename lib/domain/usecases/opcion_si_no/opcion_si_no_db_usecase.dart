import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/opcion_si_no_entity.dart';
import '../../repositories/opcion_si_no/opcion_si_no_repository_db.dart';

class OpcionSiNoUsecaseDB {
  final OpcionSiNoRepositoryDB repositoryDB;

  OpcionSiNoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveOpcionSiNoUsecaseDB(
      OpcionSiNoEntity opcionSiNo) {
    return repositoryDB.saveOpcionSiNoRepositoryDB(opcionSiNo);
  }

  Future<Either<Failure, List<OpcionSiNoEntity>>> getOpcionesSiNoUsecase() {
    return repositoryDB.getOpcionesSiNoRepositoryDB();
  }
}
