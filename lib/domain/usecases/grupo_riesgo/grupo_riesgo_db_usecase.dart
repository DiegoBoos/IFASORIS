import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/grupo_riesgo_entity.dart';
import '../../repositories/grupo_riesgo/grupo_riesgo_repository_db.dart';

class GrupoRiesgoUsecaseDB {
  final GrupoRiesgoRepositoryDB repositoryDB;

  GrupoRiesgoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveGrupoRiesgoUsecaseDB(
      GrupoRiesgoEntity grupoRiesgo) {
    return repositoryDB.saveGrupoRiesgoRepositoryDB(grupoRiesgo);
  }

  Future<Either<Failure, List<GrupoRiesgoEntity>>> getGruposRiesgoUsecase() {
    return repositoryDB.getGruposRiesgoRepositoryDB();
  }
}
