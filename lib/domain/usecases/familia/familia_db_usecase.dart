import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/familia.dart';
import '../../repositories/familia/familia_repository_db.dart';

class FamiliaUsecaseDB {
  final FamiliaRepositoryDB repositoryDB;

  FamiliaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, FamiliaEntity?>> createFamiliaUsecaseDB(
      FamiliaEntity familia) {
    return repositoryDB.createFamiliaRepositoryDB(familia);
  }

  Future<Either<Failure, List<FamiliaEntity>>> loadFamiliasUsecaseDB() {
    return repositoryDB.loadFamiliasRepositoryDB();
  }

  Future<Either<Failure, int>> deleteAfiliadoFamiliaUsecaseDB(
      int fkAfiliadoId) {
    return repositoryDB.deleteAfiliadoFamiliaRepositoryDB(fkAfiliadoId);
  }
}
