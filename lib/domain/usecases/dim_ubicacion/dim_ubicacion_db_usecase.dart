import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/dim_ubicacion.dart';
import '../../repositories/dim_ubicacion/dim_ubicacion_repository_db.dart';

class DimUbicacionUsecaseDB {
  final DimUbicacionRepositoryDB repositoryDB;

  DimUbicacionUsecaseDB(this.repositoryDB);

  Future<Either<Failure, DimUbicacionEntity>> saveDimUbicacionUsecaseDB(
      DimUbicacionEntity dimUbicacion) {
    return repositoryDB.saveDimUbicacionRepositoryDB(dimUbicacion);
  }

  Future<Either<Failure, DimUbicacionEntity?>> getDimUbicacionUsecaseDB(
      int afiliadoId, int familiaId) {
    return repositoryDB.getDimUbicacionRepositoryDB(afiliadoId, familiaId);
  }
}
