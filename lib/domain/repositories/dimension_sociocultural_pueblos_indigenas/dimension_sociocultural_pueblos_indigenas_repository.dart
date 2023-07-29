import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/dimension_sociocultural_pueblos_indigenas_entity.dart';

abstract class DimensionSocioculturalPueblosIndigenasRepository {
  Future<Either<Failure, DimensionSocioculturalPueblosIndigenasEntity>>
      uploadDimensionSocioculturalPueblosIndigenasRepository();
}
