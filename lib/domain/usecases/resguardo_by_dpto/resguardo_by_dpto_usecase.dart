import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/resguardo_entity.dart';
import '../../repositories/resguardo_by_dpto/resguardo_by_dpto_repository.dart';

class ResguardoByDptoUsecase {
  final ResguardoByDptoRepository repository;

  ResguardoByDptoUsecase(this.repository);

  Future<Either<Failure, List<ResguardoEntity>>> getResguardosByDptoUsecase(
      int dtoId) {
    return repository.getResguardosByDptoRepository(dtoId);
  }
}
