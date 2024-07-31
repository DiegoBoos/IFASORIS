import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/dim_vivienda.dart';
import '../../../domain/repositories/dim_vivienda/dim_vivienda_repository_db.dart';
import '../../datasources/local/dim_vivienda_local_ds.dart';
import '../../models/dim_vivienda.dart';

class DimViviendaRepositoryDBImpl implements DimViviendaRepositoryDB {
  final DimViviendaLocalDataSource dimViviendaLocalDataSource;

  DimViviendaRepositoryDBImpl({required this.dimViviendaLocalDataSource});

  @override
  Future<Either<Failure, int>> saveDimViviendaRepositoryDB(
      DimViviendaEntity dimVivienda) async {
    try {
      final dimViviendaModel = DimViviendaModel.fromEntity(dimVivienda);
      final result =
          await dimViviendaLocalDataSource.saveDimVivienda(dimViviendaModel);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, DimViviendaModel?>> getDimViviendaRepositoryDB(
      int afiliadoId, int familiaId) async {
    try {
      final result = await dimViviendaLocalDataSource.getDimVivienda(
          afiliadoId, familiaId);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
