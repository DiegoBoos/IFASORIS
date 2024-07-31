import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/planta_medicinal.dart';
import '../../repositories/planta_medicinal/planta_medicinal_repository.dart';

class PlantaMedicinalUsecase {
  final PlantaMedicinalRepository repository;

  PlantaMedicinalUsecase(this.repository);

  Future<Either<Failure, List<PlantaMedicinalEntity>>>
      getPlantasMedicinalesUsecase(int dtoId) {
    return repository.getPlantasMedicinalesRepository(dtoId);
  }
}
