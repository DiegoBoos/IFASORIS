import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/factor_riesgo_vivienda_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/factor_riesgo_vivienda_entity.dart';
import '../../repositories/factor_riesgo_vivienda/factor_riesgo_vivienda_repository_db.dart';

class FactorRiesgoViviendaUsecaseDB {
  final FactorRiesgoViviendaRepositoryDB repositoryDB;

  FactorRiesgoViviendaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveFactorRiesgoViviendaUsecaseDB(
      FactorRiesgoViviendaEntity factorRiesgoVivienda) {
    return repositoryDB
        .saveFactorRiesgoViviendaRepositoryDB(factorRiesgoVivienda);
  }

  Future<Either<Failure, List<FactorRiesgoViviendaEntity>>>
      getFactoresRiesgoUsecaseDB() {
    return repositoryDB.getFactoresRiesgoRepositoryDB();
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
