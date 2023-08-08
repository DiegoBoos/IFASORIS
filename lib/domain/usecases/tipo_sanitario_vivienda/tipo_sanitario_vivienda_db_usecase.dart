import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/tipo_sanitario_vivienda_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_sanitario_vivienda_entity.dart';
import '../../repositories/tipo_sanitario_vivienda/tipo_sanitario_vivienda_repository_db.dart';

class TipoSanitarioViviendaUsecaseDB {
  final TipoSanitarioViviendaRepositoryDB repositoryDB;

  TipoSanitarioViviendaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveTipoSanitarioViviendaUsecaseDB(
      TipoSanitarioViviendaEntity tipoSanitarioVivienda) {
    return repositoryDB
        .saveTipoSanitarioViviendaRepositoryDB(tipoSanitarioVivienda);
  }

  Future<Either<Failure, List<TipoSanitarioViviendaEntity>>>
      getTiposSanitarioUsecaseDB() {
    return repositoryDB.getTiposSanitarioRepositoryDB();
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
