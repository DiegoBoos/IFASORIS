import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/tipo_combustible_vivienda_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_combustible_vivienda_entity.dart';
import '../../repositories/tipo_combustible_vivienda/tipo_combustible_vivienda_repository_db.dart';

class TipoCombustibleViviendaUsecaseDB {
  final TipoCombustibleViviendaRepositoryDB repositoryDB;

  TipoCombustibleViviendaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveTipoCombustibleViviendaUsecaseDB(
      TipoCombustibleViviendaEntity tipoCombustibleVivienda) {
    return repositoryDB
        .saveTipoCombustibleViviendaRepositoryDB(tipoCombustibleVivienda);
  }

  Future<Either<Failure, List<TipoCombustibleViviendaEntity>>>
      getTiposCombustibleUsecaseDB() {
    return repositoryDB.getTiposCombustibleRepositoryDB();
  }

  Future<Either<Failure, int>> saveTiposCombustibleViviendaUsecaseDB(
      int datoViviendaId, List<LstTipoCombustible> lstTipoCombustible) {
    return repositoryDB.saveTiposCombustibleViviendaRepositoryDB(
        datoViviendaId, lstTipoCombustible);
  }

  Future<Either<Failure, List<LstTipoCombustible>>>
      getTiposCombustibleViviendaUsecaseDB(int? datoViviendaId) {
    return repositoryDB.getTiposCombustibleViviendaRepositoryDB(datoViviendaId);
  }
}
