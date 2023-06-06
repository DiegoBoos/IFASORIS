import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/leguminosa_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/leguminosa_entity.dart';
import '../../repositories/leguminosa_by_dpto/leguminosa_by_dpto_repository_db.dart';

class LeguminosaByDptoUsecaseDB {
  final LeguminosaByDptoRepositoryDB repositoryDB;

  LeguminosaByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveLeguminosaByDptoUsecaseDB(
      LeguminosaEntity leguminosa) {
    return repositoryDB.saveLeguminosaByDptoRepositoryDB(leguminosa);
  }

  Future<Either<Failure, List<LeguminosaEntity>>>
      getLeguminosasByDptoUsecaseDB() {
    return repositoryDB.getLeguminosasByDptoRepositoryDB();
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
