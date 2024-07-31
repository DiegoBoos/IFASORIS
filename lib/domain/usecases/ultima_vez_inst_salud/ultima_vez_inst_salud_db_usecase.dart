import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/ultima_vez_inst_salud.dart';
import '../../repositories/ultima_vez_inst_salud/ultima_vez_inst_salud_repository_db.dart';

class UltimaVezInstSaludUsecaseDB {
  final UltimaVezInstSaludRepositoryDB repositoryDB;

  UltimaVezInstSaludUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveUltimaVezInstSaludUsecaseDB(
      UltimaVezInstSaludEntity ultimaVezInstSalud) {
    return repositoryDB.saveUltimaVezInstSaludRepositoryDB(ultimaVezInstSalud);
  }

  Future<Either<Failure, List<UltimaVezInstSaludEntity>>>
      getUltimasVecesInstSaludUsecaseDB() {
    return repositoryDB.getUltimasVecesInstSaludRepositoryDB();
  }
}
