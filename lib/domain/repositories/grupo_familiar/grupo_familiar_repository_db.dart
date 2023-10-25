import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/grupo_familiar_entity.dart';

abstract class GrupoFamiliarRepositoryDB {
  Future<Either<Failure, int>> saveGrupoFamiliarRepositoryDB(
      List<GrupoFamiliarEntity> afiliadosGrupoFamiliar);

  Future<Either<Failure, List<GrupoFamiliarEntity>>>
      getGrupoFamiliarRepositoryDB(int familiaId);

  Future<Either<Failure, int>> deleteAfiliadoGrupoFamiliarRepositoryDB(
      int afiliadoId, int familiaId);
}
