import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/cereal.dart';

import '../../../core/error/failure.dart';
import '../../entities/cereal.dart';
import '../../repositories/cereal/cereal_repository_db.dart';

class CerealUsecaseDB {
  final CerealRepositoryDB repositoryDB;

  CerealUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveCerealUsecaseDB(CerealEntity cereal) {
    return repositoryDB.saveCerealRepositoryDB(cereal);
  }

  Future<Either<Failure, List<CerealEntity>>> getCerealesUsecaseDB() {
    return repositoryDB.getCerealesRepositoryDB();
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
