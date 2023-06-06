import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/verdura_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/verdura_entity.dart';
import '../../repositories/verdura_by_dpto/verdura_by_dpto_repository_db.dart';

class VerduraByDptoUsecaseDB {
  final VerduraByDptoRepositoryDB repositoryDB;

  VerduraByDptoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveVerduraByDptoUsecaseDB(
      VerduraEntity verdura) {
    return repositoryDB.saveVerduraByDptoRepositoryDB(verdura);
  }

  Future<Either<Failure, List<VerduraEntity>>> getVerdurasByDptoUsecaseDB() {
    return repositoryDB.getVerdurasByDptoRepositoryDB();
  }

  Future<Either<Failure, int>> saveUbicacionVerdurasUsecaseDB(
      int ubicacionId, List<LstVerdura> lstVerduras) {
    return repositoryDB.saveUbicacionVerdurasRepositoryDB(
        ubicacionId, lstVerduras);
  }

  Future<Either<Failure, List<LstVerdura>>> getUbicacionVerdurasUsecaseDB(
      int? ubicacionId) {
    return repositoryDB.getUbicacionVerdurasRepositoryDB(ubicacionId);
  }
}
