import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/metodo_planificacion.dart';

abstract class MetodoPlanificacionRepository {
  Future<Either<Failure, List<MetodoPlanificacionEntity>>>
      getMetodosPlanificacionRepository();
}
