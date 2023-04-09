import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/medio_comunicacion_entity.dart';
import '../../repositories/medio_comunicacion/medio_comunicacion_repository_db.dart';

class MedioComunicacionUsecaseDB {
  final MedioComunicacionRepositoryDB repositoryDB;

  MedioComunicacionUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveMedioComunicacionUsecase(
      MedioComunicacionEntity medioComunicacion) {
    return repositoryDB.saveMedioComunicacionRepositoryDB(medioComunicacion);
  }

  Future<Either<Failure, List<MedioComunicacionEntity>>>
      getMediosComunicacionUsecase() {
    return repositoryDB.getMediosComunicacionRepositoryDB();
  }
}
