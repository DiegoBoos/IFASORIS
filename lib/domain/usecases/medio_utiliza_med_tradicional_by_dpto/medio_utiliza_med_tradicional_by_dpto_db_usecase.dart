import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/medio_utiliza_med_tradicional_by_dpto_entity.dart';
import '../../repositories/medio_utiliza_med_tradicional_by_dpto/medio_utiliza_med_tradicional_by_dpto_repository_db.dart';

class MedioUtilizaMedTradicionalByDptoUsecaseDB {
  final MedioUtilizaMedTradicionalByDptoRepositoryDB repositoryDB;

  MedioUtilizaMedTradicionalByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveMedioUtilizaMedTradicionalByDptoUsecase(
      MedioUtilizaMedTradicionalByDptoEntity medioUtilizaMedTradicional) {
    return repositoryDB.saveMedioUtilizaMedTradicionalByDptoRepositoryDB(
        medioUtilizaMedTradicional);
  }

  Future<Either<Failure, List<MedioUtilizaMedTradicionalByDptoEntity>>>
      getMediosUtilizaMedTradicionalByDptoUsecase(int dtoId) {
    return repositoryDB.getMediosUtilizaMedTradicionalByDptoRepositoryDB(dtoId);
  }
}
