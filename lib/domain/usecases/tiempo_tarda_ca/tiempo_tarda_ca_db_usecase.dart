import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tiempo_tarda_ca.dart';
import '../../repositories/tiempo_tarda_ca/tiempo_tarda_ca_repository_db.dart';

class TiempoTardaCAUsecaseDB {
  final TiempoTardaCARepositoryDB repositoryDB;

  TiempoTardaCAUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveTiempoTardaCAUsecase(
      TiempoTardaCAEntity tiempoTardaCA) {
    return repositoryDB.saveTiempoTardaCARepositoryDB(tiempoTardaCA);
  }

  Future<Either<Failure, List<TiempoTardaCAEntity>>>
      getTiemposTardaCAUsecase() {
    return repositoryDB.getTiemposTardaCARepositoryDB();
  }
}
