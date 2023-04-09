import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/medio_utiliza_ca_entity.dart';
import '../../repositories/medio_utiliza_ca/medio_utiliza_ca_repository_db.dart';

class MedioUtilizaCAUsecaseDB {
  final MedioUtilizaCARepositoryDB repositoryDB;

  MedioUtilizaCAUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveMedioUtilizaCAUsecase(
      MedioUtilizaCAEntity medioUtilizaCA) {
    return repositoryDB.saveMedioUtilizaCARepositoryDB(medioUtilizaCA);
  }

  Future<Either<Failure, List<MedioUtilizaCAEntity>>>
      getMediosUtilizaCAUsecase() {
    return repositoryDB.getMediosUtilizaCARepositoryDB();
  }
}
