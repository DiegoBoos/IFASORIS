import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/genero.dart';
import '../../repositories/genero/genero_repository_db.dart';

class GeneroUsecaseDB {
  final GeneroRepositoryDB repositoryDB;

  GeneroUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveGeneroUsecaseDB(GeneroEntity genero) {
    return repositoryDB.saveGeneroRepositoryDB(genero);
  }

  Future<Either<Failure, List<GeneroEntity>>> getGenerosUsecaseDB() {
    return repositoryDB.getGenerosRepositoryDB();
  }
}
