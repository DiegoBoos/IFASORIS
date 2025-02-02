import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/enfermedad_tratamiento.dart';
import '../../repositories/enfermedad_tratamiento/enfermedad_tratamiento_repository_db.dart';

class EnfermedadTratamientoUsecaseDB {
  final EnfermedadTratamientoRepositoryDB repositoryDB;

  EnfermedadTratamientoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveEnfermedadTratamientoUsecaseDB(
      EnfermedadTratamientoEntity enfermedadTratamiento) {
    return repositoryDB
        .saveEnfermedadTratamientoRepositoryDB(enfermedadTratamiento);
  }

  Future<Either<Failure, List<EnfermedadTratamientoEntity>>>
      getEnfermedadesTratamientoUsecaseDB() {
    return repositoryDB.getEnfermedadesTratamientoRepositoryDB();
  }
}
