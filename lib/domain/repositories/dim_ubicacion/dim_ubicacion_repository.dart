import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/dim_ubicacion_entity.dart';

abstract class DimUbicacionRepository {
  Future<Either<Failure, DimUbicacionEntity>> createDimUbicacionRepository(
      DimUbicacionEntity dimubicacion);
}
