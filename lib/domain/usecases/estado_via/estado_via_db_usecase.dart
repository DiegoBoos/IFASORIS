import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/estado_via_entity.dart';
import '../../repositories/estado_via/estado_via_repository_db.dart';

class EstadoViaUsecaseDB {
  final EstadoViaRepositoryDB repositoryDB;

  EstadoViaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveEstadoViaUsecase(EstadoViaEntity estadoVia) {
    return repositoryDB.saveEstadoViaRepositoryDB(estadoVia);
  }

  Future<Either<Failure, List<EstadoViaEntity>>> getEstadosViasUsecase() {
    return repositoryDB.getEstadosViasRepositoryDB();
  }
}
