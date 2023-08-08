import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_vivienda_entity.dart';
import '../../repositories/tipo_vivienda/tipo_vivienda_repository_db.dart';

class TipoViviendaUsecaseDB {
  final TipoViviendaRepositoryDB repositoryDB;

  TipoViviendaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveTipoViviendaUsecaseDB(
      TipoViviendaEntity tipoVivienda) {
    return repositoryDB.saveTipoViviendaRepositoryDB(tipoVivienda);
  }

  Future<Either<Failure, List<TipoViviendaEntity>>>
      getTiposViviendaUsecaseDB() {
    return repositoryDB.getTiposViviendaRepositoryDB();
  }
}
