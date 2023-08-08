import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/leguminosa_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/leguminosa_entity.dart';
import '../../repositories/leguminosa/leguminosa_repository_db.dart';

class LeguminosaUsecaseDB {
  final LeguminosaRepositoryDB repositoryDB;

  LeguminosaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveLeguminosaUsecaseDB(
      LeguminosaEntity leguminosa) {
    return repositoryDB.saveLeguminosaRepositoryDB(leguminosa);
  }

  Future<Either<Failure, List<LeguminosaEntity>>> getLeguminosasUsecaseDB() {
    return repositoryDB.getLeguminosasRepositoryDB();
  }

  Future<Either<Failure, int>> saveUbicacionLeguminosasUsecaseDB(
      int ubicacionId, List<LstLeguminosa> lstLeguminosas) {
    return repositoryDB.saveUbicacionLeguminosasRepositoryDB(
        ubicacionId, lstLeguminosas);
  }

  Future<Either<Failure, List<LstLeguminosa>>> getUbicacionLeguminosasUsecaseDB(
      int? ubicacionId) {
    return repositoryDB.getUbicacionLeguminosasRepositoryDB(ubicacionId);
  }
}
