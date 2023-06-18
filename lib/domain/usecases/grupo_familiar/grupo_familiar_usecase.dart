import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/grupo_familiar_entity.dart';
import '../../repositories/grupo_familiar/grupo_familiar_repository.dart';

class GrupoFamiliarUsecase {
  final GrupoFamiliarRepository repository;

  GrupoFamiliarUsecase(this.repository);

  Future<Either<Failure, GrupoFamiliarEntity>> uploadGrupoFamiliarUsecase() {
    return repository.uploadGrupoFamiliarRepository();
  }
}
