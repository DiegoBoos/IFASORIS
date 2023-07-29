import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/lugar_planta_medicinal_entity.dart';

abstract class LugarPlantaMedicinalRepositoryDB {
  Future<Either<Failure, int>> saveLugarPlantaMedicinalRepositoryDB(
      LugarPlantaMedicinalEntity lugarPlantaMedicinal);

  Future<Either<Failure, List<LugarPlantaMedicinalEntity>>>
      getLugaresPlantasMedicinalesRepositoryDB();
}
