import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/dim_vivienda_entity.dart';

import '../../../core/error/failure.dart';

abstract class DimViviendaRepositoryDB {
  Future<Either<Failure, int>> saveDimViviendaRepositoryDB(
      DimViviendaEntity dimVivienda);

  Future<Either<Failure, DimViviendaEntity?>> getDimViviendaRepositoryDB(
      int familiaId);
}
