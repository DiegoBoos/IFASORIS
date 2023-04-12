import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/verdura_entity.dart';
import '../../repositories/verdura_by_dpto/verdura_by_dpto_repository.dart';

class VerduraByDptoUsecase {
  final VerduraByDptoRepository repository;

  VerduraByDptoUsecase(this.repository);

  Future<Either<Failure, List<VerduraEntity>>> getVerdurasByDptoUsecase(
      int dtoId) {
    return repository.getVerdurasByDptoRepository(dtoId);
  }
}
