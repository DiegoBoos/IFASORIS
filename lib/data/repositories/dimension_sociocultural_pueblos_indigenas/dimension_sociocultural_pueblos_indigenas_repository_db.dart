import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/dimension_sociocultural_pueblos_indigenas_entity.dart';
import '../../../domain/repositories/dimension_sociocultural_pueblos_indigenas/dimension_sociocultural_pueblos_indigenas_repository_db.dart';
import '../../datasources/local/dimension_sociocultural_pueblos_indigenas_local_ds.dart';

class DimensionSocioCulturalPueblosIndigenasRepositoryDBImpl
    implements DimensionSocioCulturalPueblosIndigenasRepositoryDB {
  final DimensionSocioCulturalPueblosIndigenasLocalDataSource
      dimensionSocioCulturalPueblosIndigenasLocalDataSource;

  DimensionSocioCulturalPueblosIndigenasRepositoryDBImpl(
      {required this.dimensionSocioCulturalPueblosIndigenasLocalDataSource});

  @override
  Future<Either<Failure, int>>
      saveDimensionSocioCulturalPueblosIndigenasRepositoryDB(
          DimensionSocioCulturalPueblosIndigenasEntity
              dimensionSocioCulturalPueblosIndigenas) async {
    try {
      final result = await dimensionSocioCulturalPueblosIndigenasLocalDataSource
          .saveDimensionSocioCulturalPueblosIndigenas(
              dimensionSocioCulturalPueblosIndigenas);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, DimensionSocioCulturalPueblosIndigenasEntity?>>
      getDimensionSocioCulturalPueblosIndigenasRepositoryDB(
          int afiliadoId) async {
    try {
      final result = await dimensionSocioCulturalPueblosIndigenasLocalDataSource
          .getDimensionSocioCulturalPueblosIndigenas(afiliadoId);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerException {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
