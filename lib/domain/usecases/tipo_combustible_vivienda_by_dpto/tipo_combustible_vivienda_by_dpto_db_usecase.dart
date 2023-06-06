import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/tipo_combustible_vivienda_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_combustible_vivienda_entity.dart';
import '../../repositories/tipo_combustible_vivienda_by_dpto/tipo_combustible_vivienda_by_dpto_repository_db.dart';

class TipoCombustibleViviendaByDptoUsecaseDB {
  final TipoCombustibleViviendaByDptoRepositoryDB repositoryDB;

  TipoCombustibleViviendaByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveTipoCombustibleViviendaByDptoUsecaseDB(
      TipoCombustibleViviendaEntity tipoCombustibleViviendaByDpto) {
    return repositoryDB.saveTipoCombustibleViviendaByDptoRepositoryDB(
        tipoCombustibleViviendaByDpto);
  }

  Future<Either<Failure, List<TipoCombustibleViviendaEntity>>>
      getTiposCombustibleViviendaByDptoUsecaseDB() {
    return repositoryDB.getTiposCombustibleViviendaByDptoRepositoryDB();
  }

  Future<Either<Failure, int>> saveTiposCombustibleViviendaUsecaseDB(
      int datoViviendaId, List<LstTiposCombustible> lstTiposCombustible) {
    return repositoryDB.saveTiposCombustibleViviendaRepositoryDB(
        datoViviendaId, lstTiposCombustible);
  }

  Future<Either<Failure, List<LstTiposCombustible>>>
      getTiposCombustibleViviendaUsecaseDB(int? datoViviendaId) {
    return repositoryDB.getTiposCombustibleViviendaRepositoryDB(datoViviendaId);
  }
}
