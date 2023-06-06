import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/techo_vivienda_model.dart';

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

  Future<Either<Failure, int>> saveTechosViviendaUsecaseDB(
      int datoViviendaId, List<LstTecho> lstTechos) {
    return repositoryDB.saveTechosViviendaRepositoryDB(
        datoViviendaId, lstTechos);
  }

  Future<Either<Failure, List<LstTecho>>> getTechosViviendaUsecaseDB(
      int? datoViviendaId) {
    return repositoryDB.getTechosViviendaRepositoryDB(datoViviendaId);
  }
}
