import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/metodo_planificacion.dart';
import '../../repositories/metodo_planificacion/metodo_planificacion_repository.dart';

class MetodoPlanificacionUsecase {
  final MetodoPlanificacionRepository repository;

  MetodoPlanificacionUsecase(this.repository);

  Future<Either<Failure, List<MetodoPlanificacionEntity>>>
      getMetodosPlanificacionUsecase() {
    return repository.getMetodosPlanificacionRepository();
  }
}
