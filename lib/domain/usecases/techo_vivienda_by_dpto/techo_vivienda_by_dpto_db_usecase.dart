import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/techo_vivienda_entity.dart';
import '../../repositories/techo_vivienda_by_dpto/techo_vivienda_by_dpto_repository_db.dart';

class TechoViviendaByDptoUsecaseDB {
  final TechoViviendaByDptoRepositoryDB repositoryDB;

  TechoViviendaByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveTechoViviendaByDptoUsecaseDB(
      TechoViviendaEntity techoVivienda) {
    return repositoryDB.saveTechoViviendaByDptoRepositoryDB(techoVivienda);
  }

  Future<Either<Failure, List<TechoViviendaEntity>>>
      getTechosViviendaByDptoUsecaseDB() {
    return repositoryDB.getTechosViviendaByDptoRepositoryDB();
  }
}
