import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/dim_ubicacion.dart';
import '../../../domain/repositories/dim_ubicacion/dim_ubicacion_repository_db.dart';
import '../../datasources/local/dim_ubicacion_local_ds.dart';
import '../../models/dim_ubicacion.dart';

class DimUbicacionRepositoryDBImpl implements DimUbicacionRepositoryDB {
  final DimUbicacionLocalDataSource dimUbicacionLocalDataSource;

  DimUbicacionRepositoryDBImpl({required this.dimUbicacionLocalDataSource});

  @override
  Future<Either<Failure, int>> saveDimUbicacionRepositoryDB(
      DimUbicacionEntity dimUbicacion) async {
    try {
      final dimUbicacionModel = DimUbicacionModel.fromEntity(dimUbicacion);
      final result =
          await dimUbicacionLocalDataSource.saveDimUbicacion(dimUbicacionModel);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, DimUbicacionModel?>> getDimUbicacionRepositoryDB(
      int afiliadoId, int familiaId) async {
    try {
      final result = await dimUbicacionLocalDataSource.getDimUbicacion(
          afiliadoId, familiaId);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
