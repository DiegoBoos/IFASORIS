import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/pueblo_indigena.dart';
import '../../repositories/pueblo_indigena/pueblo_indigena_repository.dart';

class PuebloIndigenaUsecase {
  final PuebloIndigenaRepository repository;

  PuebloIndigenaUsecase(this.repository);

  Future<Either<Failure, List<PuebloIndigenaEntity>>>
      getPueblosIndigenasUsecase(int dtoId) {
    return repository.getPueblosIndigenasRepository(dtoId);
  }
}
