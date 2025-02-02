import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/dificultad_acceso_med_tradicional.dart';

import '../../../core/error/failure.dart';
import '../../entities/dificultad_acceso_med_tradicional.dart';
import '../../repositories/dificultad_acceso_med_tradicional/dificultad_acceso_med_tradicional_repository_db.dart';

class DificultadAccesoMedTradicionalUsecaseDB {
  final DificultadAccesoMedTradicionalRepositoryDB repositoryDB;

  DificultadAccesoMedTradicionalUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveDificultadAccesoMedTradicionalUsecaseDB(
      DificultadAccesoMedTradicionalEntity dificultadAccesoMedTradicional) {
    return repositoryDB.saveDificultadAccesoMedTradicionalRepositoryDB(
        dificultadAccesoMedTradicional);
  }

  Future<Either<Failure, List<DificultadAccesoMedTradicionalEntity>>>
      getDificultadesAccesoMedTradicionalUsecase() {
    return repositoryDB.getDificultadesAccesoMedTradicionalRepositoryDB();
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
