import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/dimension_sociocultural_pueblos_indigenas_entity.dart';
import '../../repositories/dimension_sociocultural_pueblos_indigenas/dimension_sociocultural_pueblos_indigenas_repository.dart';

class DimensionSocioculturalPueblosIndigenasUsecase {
  final DimensionSocioculturalPueblosIndigenasRepository repository;

  DimensionSocioculturalPueblosIndigenasUsecase(this.repository);

  Future<Either<Failure, DimensionSocioculturalPueblosIndigenasEntity>>
      uploadDimensionSocioculturalPueblosIndigenasUsecase() {
    return repository.uploadDimensionSocioculturalPueblosIndigenasRepository();
  }
}
