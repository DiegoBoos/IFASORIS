import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/dim_vivienda_entity.dart';
import '../../../domain/repositories/dim_vivienda/dim_vivienda_repository_db.dart';
import '../../datasources/local/dim_vivienda_local_ds.dart';

class DimViviendaRepositoryDBImpl implements DimViviendaRepositoryDB {
  final DimViviendaLocalDataSource dimViviendaLocalDataSource;

  DimViviendaRepositoryDBImpl({required this.dimViviendaLocalDataSource});

  @override
  Future<Either<Failure, int>> saveDimViviendaRepositoryDB(
      DimViviendaEntity dimVivienda) async {
    try {
      final result =
          await dimViviendaLocalDataSource.saveDimVivienda(dimVivienda);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, DimViviendaEntity?>> getDimViviendaRepositoryDB(
      int afiliadoId, int familiaId) async {
    try {
      final result = await dimViviendaLocalDataSource.getDimVivienda(
          afiliadoId, familiaId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
