import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/dim_ubicacion_entity.dart';
import '../../repositories/dim_ubicacion/dim_ubicacion_repository_db.dart';

class DimUbicacionUsecaseDB {
  final DimUbicacionRepositoryDB repositoryDB;

  DimUbicacionUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveDimUbicacionUsecaseDB(
      DimUbicacionEntity dimUbicacion) {
    return repositoryDB.saveDimUbicacionRepositoryDB(dimUbicacion);
  }

  Future<Either<Failure, DimUbicacionEntity?>> getDimUbicacionUsecaseDB(
      int familiaId) {
    return repositoryDB.getDimUbicacionRepositoryDB(familiaId);
  }
}
