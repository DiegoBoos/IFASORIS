import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/hortaliza_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/hortaliza_entity.dart';
import '../../repositories/hortaliza/hortaliza_repository_db.dart';

class HortalizaUsecaseDB {
  final HortalizaRepositoryDB repositoryDB;

  HortalizaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveHortalizaUsecaseDB(
      HortalizaEntity hortaliza) {
    return repositoryDB.saveHortalizaRepositoryDB(hortaliza);
  }

  Future<Either<Failure, List<HortalizaEntity>>> getHortalizasUsecaseDB() {
    return repositoryDB.getHortalizasRepositoryDB();
  }

  Future<Either<Failure, int>> saveUbicacionHortalizasUsecaseDB(
      int ubicacionId, List<LstHortaliza> lstHortalizas) {
    return repositoryDB.saveUbicacionHortalizasRepositoryDB(
        ubicacionId, lstHortalizas);
  }

  Future<Either<Failure, List<LstHortaliza>>> getUbicacionHortalizasUsecaseDB(
      int? ubicacionId) {
    return repositoryDB.getUbicacionHortalizasRepositoryDB(ubicacionId);
  }
}
