import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/especialidad_med_tradicional_model.dart';
import 'package:ifasoris/data/models/nombre_med_tradicional_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/especialidad_med_tradicional_entity.dart';
import '../../repositories/especialidad_med_tradicional_by_dpto/especialidad_med_tradicional_by_dpto_repository_db.dart';

class EspecialidadMedTradicionalUsecaseDB {
  final EspecialidadMedTradicionalRepositoryDB repositoryDB;

  EspecialidadMedTradicionalUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveEspecialidadMedTradicionalUsecaseDB(
      EspecialidadMedTradicionalEntity especialidadMedTradicional) {
    return repositoryDB
        .saveEspecialidadMedTradicionalRepositoryDB(especialidadMedTradicional);
  }

  Future<Either<Failure, List<EspecialidadMedTradicionalEntity>>>
      getEspecialidadesMedTradicionalUsecaseDB() {
    return repositoryDB.getEspecialidadesMedTradicionalRepositoryDB();
  }

  Future<Either<Failure, int>> saveUbicacionEspecialidadMedTradicionalUsecaseDB(
      int ubicacionId, List<LstEspMedTradicional> lstEspMedTradicional) {
    return repositoryDB.saveUbicacionEspecialidadMedTradicionalRepositoryDB(
        ubicacionId, lstEspMedTradicional);
  }

  Future<Either<Failure, int>> saveUbicacionNombresMedTradicionalUsecaseDB(
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

  Future<Either<Failure, List<LstEspMedTradicional>>>
      getEspecialidadesMedTradicionalAtencionSaludUsecaseDB(
          int? atencionSaludId) {
    return repositoryDB
        .getEspecialidadesMedTradicionalAtencionSaludRepositoryDB(
            atencionSaludId);
  }

  Future<Either<Failure, int>>
      saveEspecialidadesMedTradicionalAtencionSaludUsecaseDB(
          int atencionSalud, List<LstEspMedTradicional> lstEspMedTradicional) {
    return repositoryDB
        .saveEspecialidadesMedTradicionalAtencionSaludRepositoryDB(
            atencionSalud, lstEspMedTradicional);
  }
}
