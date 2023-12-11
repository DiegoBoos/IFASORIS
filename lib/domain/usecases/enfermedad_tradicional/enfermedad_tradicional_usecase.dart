import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/enfermedad_tradicional_entity.dart';
import '../../repositories/enfermedad_tradicional/enfermedad_tradicional_repository.dart';

class EnfermedadTradicionalUsecase {
  final EnfermedadTradicionalRepository repository;

  EnfermedadTradicionalUsecase(this.repository);

  Future<Either<Failure, List<EnfermedadTradicionalEntity>>>
      getEnfermedadesTradicionalesUsecase(int dtoId) {
    return repository.getEnfermedadesTradicionalesRepository(dtoId);
  }
}
