import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/dim_vivienda.dart';

import '../../../core/error/failure.dart';

abstract class DimViviendaRepositoryDB {
  Future<Either<Failure, DimViviendaEntity>> saveDimViviendaRepositoryDB(
      DimViviendaEntity dimVivienda);

  Future<Either<Failure, DimViviendaEntity?>> getDimViviendaRepositoryDB(
      int afiliadoId, int familiaId);
}
