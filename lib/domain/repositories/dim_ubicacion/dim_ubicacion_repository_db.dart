import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/dim_ubicacion_entity.dart';

import '../../../core/error/failure.dart';

abstract class DimUbicacionRepositoryDB {
  Future<Either<Failure, DimUbicacionEntity?>> saveDimUbicacionRepositoryDB(
      DimUbicacionEntity dimubicacion);

  Future<Either<Failure, DimUbicacionEntity?>> getDimUbicacionRepositoryDB(
      int familiaId);
}
