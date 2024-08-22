import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/nro_cuarto_vivienda.dart';
import '../../repositories/nro_cuarto_vivienda/nro_cuarto_vivienda_repository_db.dart';

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
