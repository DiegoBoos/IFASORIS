import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tiempo_tarda_med_tradicional_entity.dart';
import '../../repositories/tiempo_tarda_med_tradicional/tiempo_tarda_med_tradicional_repository_db.dart';

class TiempoTardaMedTradicionalUsecaseDB {
  final TiempoTardaMedTradicionalRepositoryDB repositoryDB;

  TiempoTardaMedTradicionalUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveTiempoTardaMedTradicionalUsecase(
      TiempoTardaMedTradicionalEntity tiempoTardaMedTradicional) {
    return repositoryDB
        .saveTiempoTardaMedTradicionalRepositoryDB(tiempoTardaMedTradicional);
  }

  Future<Either<Failure, List<TiempoTardaMedTradicionalEntity>>>
      getTiemposTardaMedTradicionalUsecase() {
    return repositoryDB.getTiemposTardaMedTradicionalRepositoryDB();
  }
}
