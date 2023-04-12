import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/fruto_entity.dart';
import '../../repositories/fruto_by_dpto/fruto_by_dpto_repository.dart';

class FrutoByDptoUsecase {
  final FrutoByDptoRepository repository;

  FrutoByDptoUsecase(this.repository);

  Future<Either<Failure, List<FrutoEntity>>> getFrutosByDptoUsecase(int dtoId) {
    return repository.getFrutosByDptoRepository(dtoId);
  }
}
