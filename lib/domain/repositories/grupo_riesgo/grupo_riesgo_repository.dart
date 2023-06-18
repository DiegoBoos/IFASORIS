import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/grupo_riesgo_entity.dart';

abstract class GrupoRiesgoRepository {
  Future<Either<Failure, List<GrupoRiesgoEntity>>> getGruposRiesgoRepository();
}
