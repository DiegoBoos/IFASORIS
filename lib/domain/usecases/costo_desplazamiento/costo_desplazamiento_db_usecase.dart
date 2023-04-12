import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/costo_desplazamiento_entity.dart';
import '../../repositories/costo_desplazamiento/costo_desplazamiento_repository_db.dart';

class CostoDesplazamientoUsecaseDB {
  final CostoDesplazamientoRepositoryDB repositoryDB;

  CostoDesplazamientoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveCostoDesplazamientoUsecase(
      CostoDesplazamientoEntity costoDesplazamiento) {
    return repositoryDB
        .saveCostoDesplazamientoRepositoryDB(costoDesplazamiento);
  }

  Future<Either<Failure, List<CostoDesplazamientoEntity>>>
      getCostosDesplazamientoUsecase() {
    return repositoryDB.getCostosDesplazamientoRepositoryDB();
  }
}
