import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/especialidad_med_tradicional_by_dpto_entity.dart';
import '../../repositories/especialidad_med_tradicional_by_dpto/especialidad_med_tradicional_by_dpto_repository_db.dart';

class EspecialidadMedTradicionalByDptoUsecaseDB {
  final EspecialidadMedTradicionalByDptoRepositoryDB repositoryDB;

  EspecialidadMedTradicionalByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveEspecialidadMedTradicionalByDptoUsecaseDB(
      EspecialidadMedTradicionalByDptoEntity especialidadMedTradicionalByDpto) {
    return repositoryDB.saveEspecialidadMedTradicionalByDptoRepositoryDB(
        especialidadMedTradicionalByDpto);
  }

  Future<Either<Failure, List<EspecialidadMedTradicionalByDptoEntity>>>
      getEspecialidadesMedTradicionalByDptoUsecaseDB(int dtoId) {
    return repositoryDB
        .getEspecialidadesMedTradicionalByDptoRepositoryDB(dtoId);
  }
}
