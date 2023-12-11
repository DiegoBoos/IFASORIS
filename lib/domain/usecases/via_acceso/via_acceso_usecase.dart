import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/via_acceso_entity.dart';
import '../../repositories/via_acceso/via_acceso_repository.dart';

class ViaAccesoUsecase {
  final ViaAccesoRepository repository;

  ViaAccesoUsecase(this.repository);

  Future<Either<Failure, List<ViaAccesoEntity>>> getViasAccesoUsecase(
      int dtoId) {
    return repository.getViasAccesoRepository(dtoId);
  }
}
