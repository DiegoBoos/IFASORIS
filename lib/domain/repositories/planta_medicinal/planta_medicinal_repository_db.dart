import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/planta_medicinal_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/planta_medicinal_entity.dart';

abstract class PlantaMedicinalRepositoryDB {
  Future<Either<Failure, int>> savePlantaMedicinalRepositoryDB(
      PlantaMedicinalEntity plantaMedicinal);

  Future<Either<Failure, List<PlantaMedicinalEntity>>>
      getPlantasMedicinalesRepositoryDB();

  Future<Either<Failure, List<LstPlantaMedicinal>>>
      getPlantasMedicinalesAtencionSaludRepositoryDB(int? atencionSaludId);

  Future<Either<Failure, int>> savePlantasMedicinalesAtencionSaludRepositoryDB(
      int atencionSaludId, List<LstPlantaMedicinal> lstPlantaMedicinal);
}
