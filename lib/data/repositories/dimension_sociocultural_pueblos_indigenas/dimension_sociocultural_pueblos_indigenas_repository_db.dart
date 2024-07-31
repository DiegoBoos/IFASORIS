import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/dimension_sociocultural_pueblos_indigenas.dart';
import '../../../domain/repositories/dimension_sociocultural_pueblos_indigenas/dimension_sociocultural_pueblos_indigenas_repository_db.dart';
import '../../datasources/local/dimension_sociocultural_pueblos_indigenas_local_ds.dart';
import '../../models/dimension_sociocultural_pueblos_indigenas.dart';

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
      final dimensionSocioCulturalPueblosIndigenasModel =
          DimensionSocioCulturalPueblosIndigenasModel.fromEntity(
              dimensionSocioCulturalPueblosIndigenas);

      final result = await dimensionSocioCulturalPueblosIndigenasLocalDataSource
          .saveDimensionSocioCulturalPueblosIndigenas(
              dimensionSocioCulturalPueblosIndigenasModel);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, DimensionSocioCulturalPueblosIndigenasModel?>>
      getDimensionSocioCulturalPueblosIndigenasRepositoryDB(
          int afiliadoId) async {
    try {
      final result = await dimensionSocioCulturalPueblosIndigenasLocalDataSource
          .getDimensionSocioCulturalPueblosIndigenas(afiliadoId);

      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure(['Excepción no controlada']));
    }
  }
}
