import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/dificultad_acceso_med_tradicional_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/dificultad_acceso_med_tradicional_entity.dart';
import '../../repositories/dificultad_acceso_med_tradicional_by_dpto/dificultad_acceso_med_tradicional_by_dpto_repository_db.dart';

class DificultadAccesoMedTradicionalByDptoUsecaseDB {
  final DificultadAccesoMedTradicionalByDptoRepositoryDB repositoryDB;

  DificultadAccesoMedTradicionalByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>>
      saveDificultadAccesoMedTradicionalByDptoUsecaseDB(
          DificultadAccesoMedTradicionalEntity dificultadAccesoMedTradicional) {
    return repositoryDB.saveDificultadAccesoMedTradicionalByDptoRepositoryDB(
        dificultadAccesoMedTradicional);
  }

  Future<Either<Failure, List<DificultadAccesoMedTradicionalEntity>>>
      getDificultadesAccesoMedTradicionalByDptoUsecase() {
    return repositoryDB.getDificultadesAccesoMedTradicionalByDptoRepositoryDB();
  }

  Future<Either<Failure, int>> saveUbicacionAccesoMedTradicionalUsecaseDB(
      int ubicacionId,
      List<LstDificultadAccesoMedTradicional>
          lstDificultadAccesoMedTradicional) {
    return repositoryDB.saveUbicacionAccesoMedTradicionalRepositoryDB(
        ubicacionId, lstDificultadAccesoMedTradicional);
  }

  Future<Either<Failure, List<LstDificultadAccesoMedTradicional>>>
      getUbicacionDificultadesAccesoMedTradicionalUsecaseDB(int? ubicacionId) {
    return repositoryDB
        .getUbicacionDificultadesAccesoMedTradicionalRepositoryDB(ubicacionId);
  }
}
