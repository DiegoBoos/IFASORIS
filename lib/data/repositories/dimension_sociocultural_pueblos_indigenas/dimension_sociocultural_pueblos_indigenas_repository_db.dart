import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/dimension_sociocultural_pueblos_indigenas_entity.dart';
import '../../../domain/repositories/dimension_sociocultural_pueblos_indigenas/dimension_sociocultural_pueblos_indigenas_repository_db.dart';
import '../../datasources/local/dimension_sociocultural_pueblos_indigenas_local_ds.dart';

class DimensionSocioculturalPueblosIndigenasRepositoryDBImpl
    implements DimensionSocioculturalPueblosIndigenasRepositoryDB {
  final DimensionSocioculturalPueblosIndigenasLocalDataSource
      dimensionSocioculturalPueblosIndigenasLocalDataSource;

  DimensionSocioculturalPueblosIndigenasRepositoryDBImpl(
      {required this.dimensionSocioculturalPueblosIndigenasLocalDataSource});

  @override
  Future<Either<Failure, int>>
      saveDimensionSocioculturalPueblosIndigenasRepositoryDB(
          DimensionSocioculturalPueblosIndigenasEntity
              dimensionSocioculturalPueblosIndigenas) async {
    try {
      final result = await dimensionSocioculturalPueblosIndigenasLocalDataSource
          .saveDimensionSocioculturalPueblosIndigenas(
              dimensionSocioculturalPueblosIndigenas);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, DimensionSocioculturalPueblosIndigenasEntity?>>
      getDimensionSocioculturalPueblosIndigenasRepositoryDB(
          int afiliadoId) async {
    try {
      final result = await dimensionSocioculturalPueblosIndigenasLocalDataSource
          .getDimensionSocioculturalPueblosIndigenas(afiliadoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
