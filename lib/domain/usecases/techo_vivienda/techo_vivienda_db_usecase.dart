import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/techo_vivienda_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/techo_vivienda_entity.dart';
import '../../repositories/techo_vivienda/techo_vivienda_repository_db.dart';

class TechoViviendaUsecaseDB {
  final TechoViviendaRepositoryDB repositoryDB;

  TechoViviendaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveTechoViviendaUsecaseDB(
      TechoViviendaEntity techoVivienda) {
    return repositoryDB.saveTechoViviendaRepositoryDB(techoVivienda);
  }

  Future<Either<Failure, List<TechoViviendaEntity>>>
      getTechosViviendaUsecaseDB() {
    return repositoryDB.getTechosViviendaRepositoryDB();
  }

  Future<Either<Failure, int>> saveTechosViviendaUsecaseDB(
      int datoViviendaId, List<LstTecho> lstTecho) {
    return repositoryDB.saveTechosViviendaRepositoryDB(
        datoViviendaId, lstTecho);
  }

  Future<Either<Failure, List<LstTecho>>> getTechosViviendaViviendaUsecaseDB(
      int? datoViviendaId) {
    return repositoryDB.getTechosViviendaViviendaRepositoryDB(datoViviendaId);
  }
}
