import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/dimension_sociocultural_pueblos_indigenas_entity.dart';
import '../../repositories/dimension_sociocultural_pueblos_indigenas/dimension_sociocultural_pueblos_indigenas_repository_db.dart';

class DimensionSocioCulturalPueblosIndigenasUsecaseDB {
  final DimensionSocioCulturalPueblosIndigenasRepositoryDB repositoryDB;

  DimensionSocioCulturalPueblosIndigenasUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>>
      saveDimensionSocioCulturalPueblosIndigenasUsecaseDB(
          DimensionSocioCulturalPueblosIndigenasEntity
              dimensionSocioCulturalPueblosIndigenas) {
    return repositoryDB.saveDimensionSocioCulturalPueblosIndigenasRepositoryDB(
        dimensionSocioCulturalPueblosIndigenas);
  }

  Future<Either<Failure, DimensionSocioCulturalPueblosIndigenasEntity?>>
      getDimensionSocioCulturalPueblosIndigenasUsecaseDB(int afiliadoId) {
    return repositoryDB
        .getDimensionSocioCulturalPueblosIndigenasRepositoryDB(afiliadoId);
  }
}
