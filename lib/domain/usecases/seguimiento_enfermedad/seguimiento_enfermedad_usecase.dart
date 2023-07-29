import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/seguimiento_enfermedad_entity.dart';
import '../../repositories/seguimiento_enfermedad/seguimiento_enfermedad_repository.dart';

class SeguimientoEnfermedadUsecase {
  final SeguimientoEnfermedadRepository repository;

  SeguimientoEnfermedadUsecase(this.repository);

  Future<Either<Failure, List<SeguimientoEnfermedadEntity>>>
      getSeguimientoEnfermedadesUsecase() {
    return repository.getSeguimientoEnfermedadesRepository();
  }
}
