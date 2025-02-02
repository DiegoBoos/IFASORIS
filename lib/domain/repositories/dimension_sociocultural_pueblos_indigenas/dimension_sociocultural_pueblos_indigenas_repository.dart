import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/dimension_sociocultural_pueblos_indigenas.dart';

abstract class DimensionSocioCulturalPueblosIndigenasRepository {
  Future<Either<Failure, DimensionSocioCulturalPueblosIndigenasEntity>>
      uploadDimensionSocioCulturalPueblosIndigenasRepository();
}
