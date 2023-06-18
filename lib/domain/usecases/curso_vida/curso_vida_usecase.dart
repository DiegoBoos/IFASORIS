import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/curso_vida_entity.dart';
import '../../repositories/curso_vida/curso_vida_repository.dart';

class CursoVidaUsecase {
  final CursoVidaRepository repository;

  CursoVidaUsecase(this.repository);

  Future<Either<Failure, List<CursoVidaEntity>>> getCursosVidaUsecase() {
    return repository.getCursosVidaRepository();
  }
}
