import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/medio_utiliza_med_tradicional_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/medio_utiliza_med_tradicional_entity.dart';
import '../../repositories/medio_utiliza_med_tradicional/medio_utiliza_med_tradicional_repository_db.dart';

class MedioUtilizaMedTradicionalUsecaseDB {
  final MedioUtilizaMedTradicionalRepositoryDB repositoryDB;

  MedioUtilizaMedTradicionalUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveMedioUtilizaMedTradicionalUsecaseDB(
      MedioUtilizaMedTradicionalEntity medioUtilizaMedTradicional) {
    return repositoryDB
        .saveMedioUtilizaMedTradicionalRepositoryDB(medioUtilizaMedTradicional);
  }

  Future<Either<Failure, List<MedioUtilizaMedTradicionalEntity>>>
      getMediosUtilizaMedTradicionalUsecase() {
    return repositoryDB.getMediosUtilizaMedTradicionalRepositoryDB();
  }

  Future<Either<Failure, int>> saveUbicacionMediosMedTradicionalUsecaseDB(
      int ubicacionId, List<LstMediosMedTradicional> lstMediosMedTradicional) {
    return repositoryDB.saveUbicacionMediosMedTradicionalRepositoryDB(
        ubicacionId, lstMediosMedTradicional);
  }

  Future<Either<Failure, List<LstMediosMedTradicional>>>
      getUbicacionMediosUtilizaMedTradicionalUsecaseDB(int? ubicacionId) {
    return repositoryDB
        .getUbicacionMediosUtilizaMedTradicionalRepositoryDB(ubicacionId);
  }
}
