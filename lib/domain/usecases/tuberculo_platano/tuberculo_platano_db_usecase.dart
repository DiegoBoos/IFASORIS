import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/tuberculo_platano.dart';

import '../../../core/error/failure.dart';
import '../../entities/tuberculo_platano.dart';
import '../../repositories/tuberculo_platano/tuberculo_platano_repository_db.dart';

class TuberculoPlatanoUsecaseDB {
  final TuberculoPlatanoRepositoryDB repositoryDB;

  TuberculoPlatanoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveTuberculoPlatanoUsecaseDB(
      TuberculoPlatanoEntity tuberculoPlatano) {
    return repositoryDB.saveTuberculoPlatanoRepositoryDB(tuberculoPlatano);
  }

  Future<Either<Failure, List<TuberculoPlatanoEntity>>>
      getTuberculosPlatanosUsecaseDB() {
    return repositoryDB.getTuberculosPlatanosRepositoryDB();
  }

  Future<Either<Failure, int>> saveUbicacionTuberculosPlatanosUsecaseDB(
      int ubicacionId, List<LstTuberculo> lstTuberculos) {
    return repositoryDB.saveUbicacionTuberculosPlatanosRepositoryDB(
        ubicacionId, lstTuberculos);
  }

  Future<Either<Failure, List<LstTuberculo>>>
      getUbicacionTuberculosPlatanosUsecaseDB(int? ubicacionId) {
    return repositoryDB.getUbicacionTuberculosPlatanosRepositoryDB(ubicacionId);
  }
}
