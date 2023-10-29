import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/grupo_familiar_entity.dart';
import '../../repositories/grupo_familiar/grupo_familiar_repository_db.dart';

class GrupoFamiliarUsecaseDB {
  final GrupoFamiliarRepositoryDB repositoryDB;

  GrupoFamiliarUsecaseDB(this.repositoryDB);

  Future<Either<Failure, Map<String, dynamic>>>
      saveAfiliadoGrupoFamiliarUsecaseDB(
          GrupoFamiliarEntity afiliadoGrupoFamiliar) {
    return repositoryDB
        .saveAfiliadoGrupoFamiliarRepositoryDB(afiliadoGrupoFamiliar);
  }

  Future<Either<Failure, List<GrupoFamiliarEntity>>> getGrupoFamiliarUsecaseDB(
      int familiaId) {
    return repositoryDB.getGrupoFamiliarRepositoryDB(familiaId);
  }

  Future<Either<Failure, int>> deleteAfiliadoGrupoFamiliarUsecaseDB(
      int afiliadoId, int familiaId) {
    return repositoryDB.deleteAfiliadoGrupoFamiliarRepositoryDB(
        afiliadoId, familiaId);
  }

  Future<Either<Failure, int>> completeGrupoFamiliarUsecaseDB(int familiaId) {
    return repositoryDB.completeGrupoFamiliarRepositoryDB(familiaId);
  }
}
