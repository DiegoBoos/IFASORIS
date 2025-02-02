import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/cuarto_vivienda.dart';
import '../../repositories/cuarto_vivienda/cuarto_vivienda_repository_db.dart';

class CuartoViviendaUsecaseDB {
  final CuartoViviendaRepositoryDB repositoryDB;

  CuartoViviendaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveCuartoViviendaUsecaseDB(
      CuartoViviendaEntity cuartoVivienda) {
    return repositoryDB.saveCuartoViviendaRepositoryDB(cuartoVivienda);
  }

  Future<Either<Failure, List<CuartoViviendaEntity>>>
      getCuartosViviendaUsecaseDB() {
    return repositoryDB.getCuartosViviendaRepositoryDB();
  }
}
