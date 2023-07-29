import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/dimension_sociocultural_pueblos_indigenas_entity.dart';

abstract class DimensionSocioculturalPueblosIndigenasRepositoryDB {
  Future<Either<Failure, int>>
      saveDimensionSocioculturalPueblosIndigenasRepositoryDB(
          DimensionSocioculturalPueblosIndigenasEntity
              dimensionSocioculturalPueblosIndigenas);

  Future<Either<Failure, DimensionSocioculturalPueblosIndigenasEntity?>>
      getDimensionSocioculturalPueblosIndigenasRepositoryDB(int afiliadoId);
}
