import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/grupo_riesgo_entity.dart';

abstract class GrupoRiesgoRepositoryDB {
  Future<Either<Failure, int>> saveGrupoRiesgoRepositoryDB(
      GrupoRiesgoEntity grupoRiesgo);

  Future<Either<Failure, List<GrupoRiesgoEntity>>>
      getGruposRiesgoRepositoryDB();
}
