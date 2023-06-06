import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/cereal_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/cereal_entity.dart';
import '../../repositories/cereal_by_dpto/cereal_by_dpto_repository_db.dart';

class CerealByDptoUsecaseDB {
  final CerealByDptoRepositoryDB repositoryDB;

  CerealByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveCerealByDptoUsecaseDB(CerealEntity cereal) {
    return repositoryDB.saveCerealByDptoRepositoryDB(cereal);
  }

  Future<Either<Failure, List<CerealEntity>>> getCerealesByDptoUsecaseDB() {
    return repositoryDB.getCerealesByDptoRepositoryDB();
  }

  Future<Either<Failure, int>> saveUbicacionCerealesUsecaseDB(
      int ubicacionId, List<LstCereal> lstCereales) {
    return repositoryDB.saveUbicacionCerealesRepositoryDB(
        ubicacionId, lstCereales);
  }

  Future<Either<Failure, List<LstCereal>>> getUbicacionCerealesUsecaseDB(
      int? ubicacionId) {
    return repositoryDB.getUbicacionCerealesRepositoryDB(ubicacionId);
  }
}
