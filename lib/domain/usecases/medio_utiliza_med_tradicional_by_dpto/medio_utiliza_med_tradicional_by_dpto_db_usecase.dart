import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/medio_utiliza_med_tradicional_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/medio_utiliza_med_tradicional_entity.dart';
import '../../repositories/medio_utiliza_med_tradicional_by_dpto/medio_utiliza_med_tradicional_by_dpto_repository_db.dart';

class MedioUtilizaMedTradicionalByDptoUsecaseDB {
  final MedioUtilizaMedTradicionalByDptoRepositoryDB repositoryDB;

  MedioUtilizaMedTradicionalByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveMedioUtilizaMedTradicionalByDptoUsecaseDB(
      MedioUtilizaMedTradicionalEntity medioUtilizaMedTradicional) {
    return repositoryDB.saveMedioUtilizaMedTradicionalByDptoRepositoryDB(
        medioUtilizaMedTradicional);
  }

  Future<Either<Failure, List<MedioUtilizaMedTradicionalEntity>>>
      getMediosUtilizaMedTradicionalByDptoUsecase() {
    return repositoryDB.getMediosUtilizaMedTradicionalByDptoRepositoryDB();
  }

  Future<Either<Failure, int>> saveUbicacionMediosMedTradicionalUsecaseDB(
      int ubicacionId, List<LstMediosMedTradicional> lstMediosMedTradicional) {
    return repositoryDB.saveUbicacionMediosMedTradicionalRepositoryDB(
        ubicacionId, lstMediosMedTradicional);
  }

  Future<Either<Failure, List<LstMediosMedTradicional>>>
      getMediosUtilizaMedTradicionalUsecaseDB(int? ubicacionId) {
    return repositoryDB.getMediosUtilizaMedTradicionalRepositoryDB(ubicacionId);
  }
}
