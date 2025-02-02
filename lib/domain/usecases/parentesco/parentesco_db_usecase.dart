import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/parentesco.dart';
import '../../repositories/parentesco/parentesco_repository_db.dart';

class ParentescoUsecaseDB {
  final ParentescoRepositoryDB repositoryDB;

  ParentescoUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveParentescoUsecaseDB(
      ParentescoEntity parentesco) {
    return repositoryDB.saveParentescoRepositoryDB(parentesco);
  }

  Future<Either<Failure, List<ParentescoEntity>>> getParentescosUsecaseDB() {
    return repositoryDB.getParentescosRepositoryDB();
  }
}
