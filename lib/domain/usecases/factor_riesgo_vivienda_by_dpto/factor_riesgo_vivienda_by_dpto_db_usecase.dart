import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/factor_riesgo_vivienda_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/factor_riesgo_vivienda_entity.dart';
import '../../repositories/factor_riesgo_vivienda_by_dpto/factor_riesgo_vivienda_by_dpto_repository_db.dart';

class FactorRiesgoViviendaByDptoUsecaseDB {
  final FactorRiesgoViviendaByDptoRepositoryDB repositoryDB;

  FactorRiesgoViviendaByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveFactorRiesgoViviendaByDptoUsecaseDB(
      FactorRiesgoViviendaEntity factorRiesgoViviendaByDpto) {
    return repositoryDB
        .saveFactorRiesgoViviendaByDptoRepositoryDB(factorRiesgoViviendaByDpto);
  }

  Future<Either<Failure, List<FactorRiesgoViviendaEntity>>>
      getFactoresRiesgoViviendaByDptoUsecaseDB() {
    return repositoryDB.getFactoresRiesgoViviendaByDptoRepositoryDB();
  }

  Future<Either<Failure, int>> saveFactoresRiesgoViviendaUsecaseDB(
      int datoViviendaId, List<LstFactoresRiesgo> lstFactoresRiesgo) {
    return repositoryDB.saveFactoresRiesgoViviendaRepositoryDB(
        datoViviendaId, lstFactoresRiesgo);
  }

  Future<Either<Failure, List<LstFactoresRiesgo>>>
      getFactoresRiesgoViviendaUsecaseDB(int? datoViviendaId) {
    return repositoryDB.getFactoresRiesgoViviendaRepositoryDB(datoViviendaId);
  }
}
