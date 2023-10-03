import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/grupo_familiar_entity.dart';
import '../../repositories/grupo_familiar/grupo_familiar_repository_db.dart';

class GrupoFamiliarUsecaseDB {
  final GrupoFamiliarRepositoryDB repositoryDB;

  GrupoFamiliarUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveGrupoFamiliarUsecaseDB(
      List<GrupoFamiliarEntity> afiliadosGrupoFamiliar) {
    return repositoryDB.saveGrupoFamiliarRepositoryDB(afiliadosGrupoFamiliar);
  }

  Future<Either<Failure, List<GrupoFamiliarEntity>>> getGrupoFamiliarUsecaseDB(
      int familiaId) {
    return repositoryDB.getGrupoFamiliarRepositoryDB(familiaId);
  }

  Future<Either<Failure, int>> deleteAfiliadosGrupoFamiliarUsecaseDB(
      int familiaId) {
    return repositoryDB.deleteAfiliadosGrupoFamiliarRepositoryDB(familiaId);
  }
}
