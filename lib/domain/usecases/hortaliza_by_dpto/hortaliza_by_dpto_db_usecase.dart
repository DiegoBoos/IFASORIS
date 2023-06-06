import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/hortaliza_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/hortaliza_entity.dart';
import '../../repositories/hortaliza_by_dpto/hortaliza_by_dpto_repository_db.dart';

class HortalizaByDptoUsecaseDB {
  final HortalizaByDptoRepositoryDB repositoryDB;

  HortalizaByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveHortalizaByDptoUsecaseDB(
      HortalizaEntity hortaliza) {
    return repositoryDB.saveHortalizaByDptoRepositoryDB(hortaliza);
  }

  Future<Either<Failure, List<HortalizaEntity>>>
      getHortalizasByDptoUsecaseDB() {
    return repositoryDB.getHortalizasByDptoRepositoryDB();
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
