import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/via_acceso.dart';
import '../../repositories/via_acceso/via_acceso_repository_db.dart';

class ViaAccesoUsecaseDB {
  final ViaAccesoRepositoryDB repositoryDB;

  ViaAccesoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveViaAccesoUsecaseDB(
      ViaAccesoEntity viaAcceso) {
    return repositoryDB.saveViaAccesoRepositoryDB(viaAcceso);
  }

  Future<Either<Failure, List<ViaAccesoEntity>>> getViasAccesoUsecaseDB() {
    return repositoryDB.getViasAccesoRepositoryDB();
  }
}
