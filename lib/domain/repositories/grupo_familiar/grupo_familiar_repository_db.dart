import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/grupo_familiar_entity.dart';

abstract class GrupoFamiliarRepositoryDB {
  Future<Either<Failure, Map<String, dynamic>>>
      saveAfiliadoGrupoFamiliarRepositoryDB(
          GrupoFamiliarEntity afiliadoGrupoFamiliar);

  Future<Either<Failure, List<GrupoFamiliarEntity>>>
      getGrupoFamiliarRepositoryDB(int familiaId);

  Future<Either<Failure, int>> deleteAfiliadoGrupoFamiliarRepositoryDB(
      int afiliadoId, int familiaId);

  Future<Either<Failure, int>> completeGrupoFamiliarRepositoryDB(int familiaId);

  Future<Either<Failure, bool>> existeAfiliadoCabezaFamiliaRepositoryDB(
      int afiliadoId);
}
