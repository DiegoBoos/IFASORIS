import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/autoridad_indigena_entity.dart';
import '../../repositories/autoridad_indigena/autoridad_indigena_repository.dart';

class AutoridadIndigenaUsecase {
  final AutoridadIndigenaRepository repository;

  AutoridadIndigenaUsecase(this.repository);

  Future<Either<Failure, List<AutoridadIndigenaEntity>>>
      getAutoridadesIndigenasUsecase(int dtoId) {
    return repository.getAutoridadesIndigenasRepository(dtoId);
  }
}
