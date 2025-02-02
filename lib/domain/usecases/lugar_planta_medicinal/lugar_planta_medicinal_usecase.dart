import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/lugar_planta_medicinal.dart';
import '../../repositories/lugar_planta_medicinal/lugar_planta_medicinal_repository.dart';

class LugarPlantaMedicinalUsecase {
  final LugarPlantaMedicinalRepository repository;

  LugarPlantaMedicinalUsecase(this.repository);

  Future<Either<Failure, List<LugarPlantaMedicinalEntity>>>
      getLugaresPlantasMedicinalesUsecase(int dtoId) {
    return repository.getLugaresPlantasMedicinalesRepository(dtoId);
  }
}
