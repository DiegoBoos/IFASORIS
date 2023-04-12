import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/hortaliza_entity.dart';
import '../../repositories/hortaliza_by_dpto/hortaliza_by_dpto_repository.dart';

class HortalizaByDptoUsecase {
  final HortalizaByDptoRepository repository;

  HortalizaByDptoUsecase(this.repository);

  Future<Either<Failure, List<HortalizaEntity>>> getHortalizasByDptoUsecase(
      int dtoId) {
    return repository.getHortalizasByDptoRepository(dtoId);
  }
}
