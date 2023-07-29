import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/metodo_planificacion_entity.dart';

abstract class MetodoPlanificacionRepositoryDB {
  Future<Either<Failure, int>> saveMetodoPlanificacionRepositoryDB(
      MetodoPlanificacionEntity metodoPlanificacion);

  Future<Either<Failure, List<MetodoPlanificacionEntity>>>
      getMetodosPlanificacionRepositoryDB();
}
