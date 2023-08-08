import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/dimension_sociocultural_pueblos_indigenas_entity.dart';

abstract class DimensionSocioCulturalPueblosIndigenasRepositoryDB {
  Future<Either<Failure, int>>
      saveDimensionSocioCulturalPueblosIndigenasRepositoryDB(
          DimensionSocioCulturalPueblosIndigenasEntity
              dimensionSocioCulturalPueblosIndigenas);

  Future<Either<Failure, DimensionSocioCulturalPueblosIndigenasEntity?>>
      getDimensionSocioCulturalPueblosIndigenasRepositoryDB(int afiliadoId);
}
