import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_vivienda_entity.dart';
import '../../repositories/tipo_vivienda_by_dpto/tipo_vivienda_by_dpto_repository_db.dart';

class TipoViviendaByDptoUsecaseDB {
  final TipoViviendaByDptoRepositoryDB repositoryDB;

  TipoViviendaByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveTipoViviendaByDptoUsecaseDB(
      TipoViviendaEntity tipoVivienda) {
    return repositoryDB.saveTipoViviendaByDptoRepositoryDB(tipoVivienda);
  }

  Future<Either<Failure, List<TipoViviendaEntity>>>
      getTiposViviendaByDptoUsecaseDB() {
    return repositoryDB.getTiposViviendaByDptoRepositoryDB();
  }
}
