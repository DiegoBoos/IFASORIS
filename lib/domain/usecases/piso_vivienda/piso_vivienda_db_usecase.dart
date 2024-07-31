import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../data/models/piso_vivienda.dart';
import '../../entities/piso_vivienda.dart';
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

  Future<Either<Failure, List<LstPiso>>> getPisosViviendaViviendaUsecaseDB(
      int? datoViviendaId) {
    return repositoryDB.getPisosViviendaViviendaRepositoryDB(datoViviendaId);
  }

  Future<Either<Failure, int>> savePisosViviendaUsecaseDB(
      int datoViviendaId, List<LstPiso> lstPiso) {
    return repositoryDB.savePisosViviendaRepositoryDB(datoViviendaId, lstPiso);
  }
}
