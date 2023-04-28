import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/dim_ubicacion_entity.dart';
import '../../../domain/repositories/dim_ubicacion/dim_ubicacion_repository_db.dart';
import '../../datasources/local/dim_ubicacion_local_ds.dart';

class DimUbicacionRepositoryDBImpl implements DimUbicacionRepositoryDB {
  final DimUbicacionLocalDataSource dimUbicacionLocalDataSource;

  DimUbicacionRepositoryDBImpl({required this.dimUbicacionLocalDataSource});

  @override
  Future<Either<Failure, DimUbicacionEntity?>> saveDimUbicacionRepositoryDB(
      DimUbicacionEntity dimUbicacion) async {
    try {
      final result =
          await dimUbicacionLocalDataSource.saveDimUbicacion(dimUbicacion);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, DimUbicacionEntity?>> getDimUbicacionRepositoryDB(
      int familiaId) async {
    try {
      final result =
          await dimUbicacionLocalDataSource.getDimUbicacion(familiaId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
