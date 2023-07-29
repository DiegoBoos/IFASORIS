import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/enfermedad_tratamiento_entity.dart';
import '../../repositories/enfermedad_tratamiento/enfermedad_tratamiento_repository.dart';

class EnfermedadTratamientoUsecase {
  final EnfermedadTratamientoRepository repository;

  EnfermedadTratamientoUsecase(this.repository);

  Future<Either<Failure, List<EnfermedadTratamientoEntity>>>
      getEnfermedadesTratamientoUsecase() {
    return repository.getEnfermedadesTratamientoRepository();
  }
}
