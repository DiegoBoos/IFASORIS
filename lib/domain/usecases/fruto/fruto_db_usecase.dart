import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/fruto_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/fruto_entity.dart';
import '../../repositories/fruto/fruto_repository_db.dart';

class FrutoUsecaseDB {
  final FrutoRepositoryDB repositoryDB;

  FrutoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveFrutoUsecaseDB(FrutoEntity fruto) {
    return repositoryDB.saveFrutoRepositoryDB(fruto);
  }

  Future<Either<Failure, List<FrutoEntity>>> getFrutosUsecaseDB() {
    return repositoryDB.getFrutosRepositoryDB();
  }

  Future<Either<Failure, int>> saveUbicacionFrutosUsecaseDB(
      int ubicacionId, List<LstFruto> lstFrutos) {
    return repositoryDB.saveUbicacionFrutosRepositoryDB(ubicacionId, lstFrutos);
  }

  Future<Either<Failure, List<LstFruto>>> getUbicacionFrutosUsecaseDB(
      int? ubicacionId) {
    return repositoryDB.getUbicacionFrutosRepositoryDB(ubicacionId);
  }
}
