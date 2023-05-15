import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/dim_vivienda_entity.dart';
import '../../repositories/dim_vivienda/dim_vivienda_repository_db.dart';

class DimViviendaUsecaseDB {
  final DimViviendaRepositoryDB repositoryDB;

  DimViviendaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveDimViviendaUsecaseDB(
      DimViviendaEntity dimVivienda) {
    return repositoryDB.saveDimViviendaRepositoryDB(dimVivienda);
  }

  Future<Either<Failure, DimViviendaEntity?>> getDimViviendaUsecaseDB(
      int familiaId) {
    return repositoryDB.getDimViviendaRepositoryDB(familiaId);
  }
}
