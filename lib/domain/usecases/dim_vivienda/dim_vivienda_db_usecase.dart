import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/dim_vivienda.dart';
import '../../repositories/dim_vivienda/dim_vivienda_repository_db.dart';

class DimViviendaUsecaseDB {
  final DimViviendaRepositoryDB repositoryDB;

  DimViviendaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, DimViviendaEntity>> saveDimViviendaUsecaseDB(
      DimViviendaEntity dimVivienda) {
    return repositoryDB.saveDimViviendaRepositoryDB(dimVivienda);
  }

  Future<Either<Failure, DimViviendaEntity?>> getDimViviendaUsecaseDB(
      int afiliadoId, int familiaId) {
    return repositoryDB.getDimViviendaRepositoryDB(afiliadoId, familiaId);
  }
}
