import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/dificultad_acceso_ca.dart';

import '../../../core/error/failure.dart';
import '../../entities/dificultad_acceso_ca.dart';
import '../../repositories/dificultad_acceso_ca/dificultad_acceso_ca_repository_db.dart';

class DificultadAccesoCAUsecaseDB {
  final DificultadAccesoCARepositoryDB repositoryDB;

  DificultadAccesoCAUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveDificultadAccesoCAUsecase(
      DificultadAccesoCAEntity dificultadAccesoCA) {
    return repositoryDB.saveDificultadAccesoCARepositoryDB(dificultadAccesoCA);
  }

  Future<Either<Failure, List<DificultadAccesoCAEntity>>>
      getDificultadesAccesoCAUsecase() {
    return repositoryDB.getDificultadesAccesoCARepositoryDB();
  }

  Future<Either<Failure, int>> saveUbicacionDificultadesAccesoUsecaseDB(
      int ubicacionId,
      List<LstDificultadAccesoAtencion> lstDificultadAccesoAtencion) {
    return repositoryDB.saveUbicacionDificultadesAccesoRepositoryDB(
        ubicacionId, lstDificultadAccesoAtencion);
  }

  Future<Either<Failure, List<LstDificultadAccesoAtencion>>>
      getUbicacionDificultadesAccesoUsecaseDB(int? ubicacionId) {
    return repositoryDB.getUbicacionDificultadesAccesoRepositoryDB(ubicacionId);
  }
}
