import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/familia_entity.dart';
import '../../repositories/familia/familia_repository_db.dart';

class FamiliaUsecaseDB {
  final FamiliaRepositoryDB repositoryDB;

  FamiliaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, FamiliaEntity?>> logInUsecaseDB(
      FamiliaEntity familia) {
    return repositoryDB.createFamiliaRepositoryDB(familia);
  }
}
