import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/lugar_planta_medicinal.dart';

abstract class LugarPlantaMedicinalRepository {
  Future<Either<Failure, List<LugarPlantaMedicinalEntity>>>
      getLugaresPlantasMedicinalesRepository(int dtoId);
}
