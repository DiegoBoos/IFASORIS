import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/metodo_planificacion_entity.dart';

abstract class MetodoPlanificacionRepository {
  Future<Either<Failure, List<MetodoPlanificacionEntity>>>
      getMetodosPlanificacionRepository();
}
