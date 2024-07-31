import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../data/models/planta_medicinal.dart';
import '../../entities/planta_medicinal.dart';
import '../../repositories/planta_medicinal/planta_medicinal_repository_db.dart';

class PlantaMedicinalUsecaseDB {
  final PlantaMedicinalRepositoryDB repositoryDB;

  PlantaMedicinalUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> savePlantaMedicinalUsecaseDB(
      PlantaMedicinalEntity plantaMedicinal) {
    return repositoryDB.savePlantaMedicinalRepositoryDB(plantaMedicinal);
  }

  Future<Either<Failure, List<PlantaMedicinalEntity>>>
      getPlantasMedicinalesUsecaseDB() {
    return repositoryDB.getPlantasMedicinalesRepositoryDB();
  }

  Future<Either<Failure, List<LstPlantaMedicinal>>>
      getPlantasMedicinalesAtencionSaludUsecaseDB(int? atencionSaludId) {
    return repositoryDB
        .getPlantasMedicinalesAtencionSaludRepositoryDB(atencionSaludId);
  }

  Future<Either<Failure, int>> savePlantasMedicinalesAtencionSaludUsecaseDB(
      int atencionSalud, List<LstPlantaMedicinal> lstPlantaMedicinal) {
    return repositoryDB.savePlantasMedicinalesAtencionSaludRepositoryDB(
        atencionSalud, lstPlantaMedicinal);
  }
}
