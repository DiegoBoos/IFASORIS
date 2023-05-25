import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/tipo_calendario_entity.dart';
import '../../repositories/tipo_calendario/tipo_calendario_repository_db.dart';

class TipoCalendarioUsecaseDB {
  final TipoCalendarioRepositoryDB repositoryDB;

  TipoCalendarioUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveTipoCalendarioUsecaseDB(
      TipoCalendarioEntity tipoCalendario) {
    return repositoryDB.saveTipoCalendarioRepositoryDB(tipoCalendario);
  }

  Future<Either<Failure, List<TipoCalendarioEntity>>>
      getTiposCalendarioUsecaseDB() {
    return repositoryDB.getTiposCalendarioRepositoryDB();
  }
}
