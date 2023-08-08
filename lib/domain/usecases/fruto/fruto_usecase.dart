import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/fruto_entity.dart';
import '../../repositories/fruto/fruto_repository.dart';

class FrutoUsecase {
  final FrutoRepository repository;

  FrutoUsecase(this.repository);

  Future<Either<Failure, List<FrutoEntity>>> getFrutosUsecase(int dtoId) {
    return repository.getFrutosRepository(dtoId);
  }
}
