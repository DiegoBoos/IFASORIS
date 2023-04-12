import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/leguminosa_entity.dart';
import '../../repositories/leguminosa_by_dpto/leguminosa_by_dpto_repository.dart';

class LeguminosaByDptoUsecase {
  final LeguminosaByDptoRepository repository;

  LeguminosaByDptoUsecase(this.repository);

  Future<Either<Failure, List<LeguminosaEntity>>> getLeguminosasByDptoUsecase(
      int dtoId) {
    return repository.getLeguminosasByDptoRepository(dtoId);
  }
}
