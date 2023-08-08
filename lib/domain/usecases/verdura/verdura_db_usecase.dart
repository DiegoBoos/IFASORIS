import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/verdura_model.dart';

import '../../../core/error/failure.dart';
import '../../entities/verdura_entity.dart';
import '../../repositories/verdura/verdura_repository_db.dart';

class VerduraUsecaseDB {
  final VerduraRepositoryDB repositoryDB;

  VerduraUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveVerduraUsecaseDB(VerduraEntity verdura) {
    return repositoryDB.saveVerduraRepositoryDB(verdura);
  }

  Future<Either<Failure, List<VerduraEntity>>> getVerdurasUsecaseDB() {
    return repositoryDB.getVerdurasRepositoryDB();
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
