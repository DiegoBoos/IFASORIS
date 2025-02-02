import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/planta_medicinal.dart';

abstract class PlantaMedicinalRepository {
  Future<Either<Failure, List<PlantaMedicinalEntity>>>
      getPlantasMedicinalesRepository(int dtoId);
}
