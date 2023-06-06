import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/especialidad_med_tradicional_model.dart';
import 'package:ifasoris/data/models/nombre_med_tradicional_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/especialidad_med_tradicional_entity.dart';
import '../../repositories/especialidad_med_tradicional_by_dpto/especialidad_med_tradicional_by_dpto_repository_db.dart';

class EspecialidadMedTradicionalByDptoUsecaseDB {
  final EspecialidadMedTradicionalByDptoRepositoryDB repositoryDB;

  EspecialidadMedTradicionalByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveEspecialidadMedTradicionalByDptoUsecaseDB(
      EspecialidadMedTradicionalEntity especialidadMedTradicionalByDpto) {
    return repositoryDB.saveEspecialidadMedTradicionalByDptoRepositoryDB(
        especialidadMedTradicionalByDpto);
  }

  Future<Either<Failure, List<EspecialidadMedTradicionalEntity>>>
      getEspecialidadesMedTradicionalByDptoUsecaseDB() {
    return repositoryDB.getEspecialidadesMedTradicionalByDptoRepositoryDB();
  }

  saveUbicacionEspecialidadMedTradicionalUsecaseDB(
      int ubicacionId, List<LstEspMedTradicional> lstEspMedTradicional) {
    return repositoryDB.saveUbicacionEspecialidadMedTradicionalRepositoryDB(
        ubicacionId, lstEspMedTradicional);
  }

  saveUbicacionNombresMedTradicionalUsecaseDB(
      int ubicacionId, List<LstNombreMedTradicional> lstNombreMedTradicional) {
    return repositoryDB.saveUbicacionNombresMedTradicionalRepositoryDB(
        ubicacionId, lstNombreMedTradicional);
  }

  Future<Either<Failure, List<LstEspMedTradicional>>>
      getUbicacionEspecialidadesMedTradicionalUsecaseDB(int? ubicacionId) {
    return repositoryDB
        .getUbicacionEspecialidadesMedTradicionalRepositoryDB(ubicacionId);
  }

  Future<Either<Failure, List<LstNombreMedTradicional>>>
      getUbicacionNombresMedTradicionalUsecaseDB(int? ubicacionId) {
    return repositoryDB
        .getUbicacionNombresMedTradicionalRepositoryDB(ubicacionId);
  }
}
