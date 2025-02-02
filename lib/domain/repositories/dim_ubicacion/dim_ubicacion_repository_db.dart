import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/dim_ubicacion.dart';

import '../../../core/error/failure.dart';

abstract class DimUbicacionRepositoryDB {
  Future<Either<Failure, int>> saveDimUbicacionRepositoryDB(
      DimUbicacionEntity dimUbicacion);

  Future<Either<Failure, DimUbicacionEntity?>> getDimUbicacionRepositoryDB(
      int afiliadoId, int familiaId);
}
