import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/medio_utiliza_ca.dart';

import '../../../core/error/failure.dart';
import '../../entities/medio_utiliza_ca.dart';
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

  Future<Either<Failure, List<LstMediosUtilizaCA>>>
      getUbicacionMediosUtilizaCAUsecaseDB(int? datoViviendaId) {
    return repositoryDB.getUbicacionMediosUtilizaCARepositoryDB(datoViviendaId);
  }

  Future<Either<Failure, int>> saveUbicacionMediosUtilizaCAUsecaseDB(
      int datoViviendaId, List<LstMediosUtilizaCA> lstCuarto) {
    return repositoryDB.saveUbicacionMediosUtilizaCARepositoryDB(
        datoViviendaId, lstCuarto);
  }
}
