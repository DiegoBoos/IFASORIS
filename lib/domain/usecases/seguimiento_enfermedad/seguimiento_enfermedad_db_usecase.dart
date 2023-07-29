import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/seguimiento_enfermedad_entity.dart';
import '../../repositories/seguimiento_enfermedad/seguimiento_enfermedad_repository_db.dart';

class SeguimientoEnfermedadUsecaseDB {
  final SeguimientoEnfermedadRepositoryDB repositoryDB;

  SeguimientoEnfermedadUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveSeguimientoEnfermedadUsecaseDB(
      SeguimientoEnfermedadEntity seguimientoEnfermedad) {
    return repositoryDB
        .saveSeguimientoEnfermedadRepositoryDB(seguimientoEnfermedad);
  }

  Future<Either<Failure, List<SeguimientoEnfermedadEntity>>>
      getSeguimientoEnfermedadesUsecaseDB() {
    return repositoryDB.getSeguimientoEnfermedadesRepositoryDB();
  }
}
