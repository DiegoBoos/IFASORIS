import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/estadistica_entity.dart';

import '../../../core/error/failure.dart';
import '../../entities/ficha_entity.dart';
import '../../repositories/ficha/ficha_repository_db.dart';

class FichaUsecaseDB {
  final FichaRepositoryDB repositoryDB;

  FichaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, FichaEntity>> createFichaUsecaseDB(FichaEntity ficha) {
    return repositoryDB.createFichaRepositoryDB(ficha);
  }

  Future<Either<Failure, int>> createFichaCompletaUsecaseDB(FichaEntity ficha) {
    return repositoryDB.createFichaCompletaRepositoryDB(ficha);
  }

  Future<Either<Failure, List<FichaEntity>>> loadFichasUsecaseDB(
      int familiaId) {
    return repositoryDB.loadFichasRepositoryDB(familiaId);
  }

  Future<Either<Failure, int>> deleteFichaUsecaseDB(int fichaId) {
    return repositoryDB.deleteFichaRepositoryDB(fichaId);
  }

  Future<Either<Failure, List<FichaEntity>>> loadFichasSincronizadasUsecaseDB(
      int familiaId) {
    return repositoryDB.loadFichasSincronizadasRepositoryDB(familiaId);
  }

  Future<Either<Failure, List<EstadisticaEntity>>> loadEstadisticasUsecaseDB() {
    return repositoryDB.loadEstadisticasRepositoryDB();
  }
}
