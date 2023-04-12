import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/cereal_entity.dart';
import '../../repositories/cereal_by_dpto/cereal_by_dpto_repository.dart';

class CerealByDptoUsecase {
  final CerealByDptoRepository repository;

  CerealByDptoUsecase(this.repository);

  Future<Either<Failure, List<CerealEntity>>> getCerealesByDptoUsecase(
      int dtoId) {
    return repository.getCerealesByDptoRepository(dtoId);
  }
}
