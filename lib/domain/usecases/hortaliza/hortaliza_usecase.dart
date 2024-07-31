import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/hortaliza.dart';
import '../../repositories/hortaliza/hortaliza_repository.dart';

class HortalizaUsecase {
  final HortalizaRepository repository;

  HortalizaUsecase(this.repository);

  Future<Either<Failure, List<HortalizaEntity>>> getHortalizasUsecase(
      int dtoId) {
    return repository.getHortalizasRepository(dtoId);
  }
}
