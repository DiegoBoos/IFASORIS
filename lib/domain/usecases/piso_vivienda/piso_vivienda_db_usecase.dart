import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/piso_vivienda_entity.dart';
import '../../repositories/piso_vivienda/piso_vivienda_repository_db.dart';

class PisoViviendaUsecaseDB {
  final PisoViviendaRepositoryDB repositoryDB;

  PisoViviendaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> savePisoViviendaUsecaseDB(
      PisoViviendaEntity pisoVivienda) {
    return repositoryDB.savePisoViviendaRepositoryDB(pisoVivienda);
  }

  Future<Either<Failure, List<PisoViviendaEntity>>>
      getPisosViviendaUsecaseDB() {
    return repositoryDB.getPisosViviendaRepositoryDB();
  }
}
