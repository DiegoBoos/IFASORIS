import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/cuarto_vivienda_entity.dart';
import '../../repositories/cuarto_vivienda/cuarto_vivienda_repository_db.dart';

class NroCuartoViviendaUsecaseDB {
  final NroCuartoViviendaRepositoryDB repositoryDB;

  NroCuartoViviendaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveNroCuartoViviendaUsecaseDB(
      NroCuartoViviendaEntity nroCuartoVivienda) {
    return repositoryDB.saveNroCuartoViviendaRepositoryDB(nroCuartoVivienda);
  }

  Future<Either<Failure, List<NroCuartoViviendaEntity>>>
      getNroCuartosViviendaUsecaseDB() {
    return repositoryDB.getNroCuartosViviendaRepositoryDB();
  }
}
