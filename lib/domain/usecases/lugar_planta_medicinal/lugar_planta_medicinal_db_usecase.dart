import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/lugar_planta_medicinal.dart';
import '../../repositories/lugar_planta_medicinal/lugar_planta_medicinal_repository_db.dart';

class LugarPlantaMedicinalUsecaseDB {
  final LugarPlantaMedicinalRepositoryDB repositoryDB;

  LugarPlantaMedicinalUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveLugarPlantaMedicinalUsecaseDB(
      LugarPlantaMedicinalEntity lugarPlantaMedicinal) {
    return repositoryDB
        .saveLugarPlantaMedicinalRepositoryDB(lugarPlantaMedicinal);
  }

  Future<Either<Failure, List<LugarPlantaMedicinalEntity>>>
      getLugaresPlantasMedicinalesUsecaseDB() {
    return repositoryDB.getLugaresPlantasMedicinalesRepositoryDB();
  }
}
