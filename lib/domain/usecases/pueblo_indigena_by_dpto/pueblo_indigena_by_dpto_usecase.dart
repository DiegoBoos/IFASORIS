import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/pueblo_indigena_entity.dart';
import '../../repositories/pueblo_indigena_by_dpto/pueblo_indigena_by_dpto_repository.dart';

class PuebloIndigenaByDptoUsecase {
  final PuebloIndigenaByDptoRepository repository;

  PuebloIndigenaByDptoUsecase(this.repository);

  Future<Either<Failure, List<PuebloIndigenaEntity>>>
      getPueblosIndigenasByDptoUsecase(int dtoId) {
    return repository.getPueblosIndigenasByDptoRepository(dtoId);
  }
}
