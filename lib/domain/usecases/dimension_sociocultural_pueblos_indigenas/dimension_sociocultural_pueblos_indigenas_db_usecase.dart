import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/dimension_sociocultural_pueblos_indigenas_entity.dart';
import '../../repositories/dimension_sociocultural_pueblos_indigenas/dimension_sociocultural_pueblos_indigenas_repository_db.dart';

class DimensionSocioculturalPueblosIndigenasUsecaseDB {
  final DimensionSocioculturalPueblosIndigenasRepositoryDB repositoryDB;

  DimensionSocioculturalPueblosIndigenasUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>>
      saveDimensionSocioculturalPueblosIndigenasUsecaseDB(
          DimensionSocioculturalPueblosIndigenasEntity
              dimensionSocioculturalPueblosIndigenas) {
    return repositoryDB.saveDimensionSocioculturalPueblosIndigenasRepositoryDB(
        dimensionSocioculturalPueblosIndigenas);
  }

  Future<Either<Failure, DimensionSocioculturalPueblosIndigenasEntity?>>
      getDimensionSocioculturalPueblosIndigenasUsecaseDB(int afiliadoId) {
    return repositoryDB
        .getDimensionSocioculturalPueblosIndigenasRepositoryDB(afiliadoId);
  }
}
