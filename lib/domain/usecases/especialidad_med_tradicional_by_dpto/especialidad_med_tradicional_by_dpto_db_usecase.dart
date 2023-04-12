import 'package:dartz/dartz.dart';

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
}
