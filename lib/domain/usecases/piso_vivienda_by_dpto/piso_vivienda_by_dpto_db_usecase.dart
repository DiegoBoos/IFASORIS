import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/piso_vivienda_entity.dart';
import '../../repositories/piso_vivienda_by_dpto/piso_vivienda_by_dpto_repository_db.dart';

class PisoViviendaByDptoUsecaseDB {
  final PisoViviendaByDptoRepositoryDB repositoryDB;

  PisoViviendaByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> savePisoViviendaByDptoUsecaseDB(
      PisoViviendaEntity pisoVivienda) {
    return repositoryDB.savePisoViviendaByDptoRepositoryDB(pisoVivienda);
  }

  Future<Either<Failure, List<PisoViviendaEntity>>>
      getPisosViviendaByDptoUsecaseDB() {
    return repositoryDB.getPisosViviendaByDptoRepositoryDB();
  }
}
