import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/dificultad_acceso_med_tradicional_entity.dart';
import '../../repositories/dificultad_acceso_med_tradicional_by_dpto/dificultad_acceso_med_tradicional_by_dpto_repository_db.dart';

class DificultadAccesoMedTradicionalByDptoUsecaseDB {
  final DificultadAccesoMedTradicionalByDptoRepositoryDB repositoryDB;

  DificultadAccesoMedTradicionalByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveDificultadAccesoMedTradicionalByDptoUsecase(
      DificultadAccesoMedTradicionalEntity
          dificultadAccesoMedTradicionalByDpto) {
    return repositoryDB.saveDificultadAccesoMedTradicionalByDptoRepositoryDB(
        dificultadAccesoMedTradicionalByDpto);
  }

  Future<Either<Failure, List<DificultadAccesoMedTradicionalEntity>>>
      getDificultadesAccesoMedTradicionalByDptoUsecase() {
    return repositoryDB.getDificultadesAccesoMedTradicionalByDptoRepositoryDB();
  }
}
