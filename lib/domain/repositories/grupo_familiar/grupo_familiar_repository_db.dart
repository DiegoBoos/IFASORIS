import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/grupo_familiar_entity.dart';

abstract class GrupoFamiliarRepositoryDB {
  Future<Either<Failure, int>> saveGrupoFamiliarRepositoryDB(
      GrupoFamiliarEntity grupoFamiliar);

  Future<Either<Failure, GrupoFamiliarEntity?>> getGrupoFamiliarRepositoryDB(
      int familiaId);
}
