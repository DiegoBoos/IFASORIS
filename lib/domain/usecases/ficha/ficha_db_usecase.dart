import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/estadistica.dart';
import '../../entities/ficha.dart';
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

  Future<Either<Failure, List<FichaEntity>>>
      loadFichasSincronizadasUsecaseDB() {
    return repositoryDB.loadFichasSincronizadasRepositoryDB();
  }

  Future<Either<Failure, List<EstadisticaEntity>>> loadEstadisticasUsecaseDB() {
    return repositoryDB.loadEstadisticasRepositoryDB();
  }
}
