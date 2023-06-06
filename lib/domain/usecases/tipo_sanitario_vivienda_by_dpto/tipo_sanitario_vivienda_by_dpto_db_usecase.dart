import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/tipo_sanitario_vivienda_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_sanitario_vivienda_entity.dart';
import '../../repositories/tipo_sanitario_vivienda_by_dpto/tipo_sanitario_vivienda_by_dpto_repository_db.dart';

class TipoSanitarioViviendaByDptoUsecaseDB {
  final TipoSanitarioViviendaByDptoRepositoryDB repositoryDB;

  TipoSanitarioViviendaByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveTipoSanitarioViviendaByDptoUsecaseDB(
      TipoSanitarioViviendaEntity tipoSanitarioViviendaByDpto) {
    return repositoryDB.saveTipoSanitarioViviendaByDptoRepositoryDB(
        tipoSanitarioViviendaByDpto);
  }

  Future<Either<Failure, List<TipoSanitarioViviendaEntity>>>
      getTiposSanitarioViviendaByDptoUsecaseDB() {
    return repositoryDB.getTiposSanitarioViviendaByDptoRepositoryDB();
  }

  Future<Either<Failure, int>> saveTiposSanitarioViviendaUsecaseDB(
      int datoViviendaId, List<LstTiposSanitario> lstTiposSanitario) {
    return repositoryDB.saveTiposSanitarioViviendaRepositoryDB(
        datoViviendaId, lstTiposSanitario);
  }

  Future<Either<Failure, List<LstTiposSanitario>>>
      getTiposSanitarioViviendaUsecaseDB(int? datoViviendaId) {
    return repositoryDB.getTiposSanitarioViviendaRepositoryDB(datoViviendaId);
  }
}
