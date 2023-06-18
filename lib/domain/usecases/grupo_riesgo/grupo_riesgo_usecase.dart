import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/grupo_riesgo_entity.dart';
import '../../repositories/grupo_riesgo/grupo_riesgo_repository.dart';

class GrupoRiesgoUsecase {
  final GrupoRiesgoRepository repository;

  GrupoRiesgoUsecase(this.repository);

  Future<Either<Failure, List<GrupoRiesgoEntity>>> getGruposRiesgoUsecase() {
    return repository.getGruposRiesgoRepository();
  }
}
