import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/cereal_entity.dart';
import '../../repositories/cereal/cereal_repository.dart';

class CerealUsecase {
  final CerealRepository repository;

  CerealUsecase(this.repository);

  Future<Either<Failure, List<CerealEntity>>> getCerealesUsecase(int dtoId) {
    return repository.getCerealesRepository(dtoId);
  }
}
