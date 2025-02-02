import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/curso_vida.dart';
import '../../repositories/curso_vida/curso_vida_repository_db.dart';

class CursoVidaUsecaseDB {
  final CursoVidaRepositoryDB repositoryDB;

  CursoVidaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveCursoVidaUsecaseDB(
      CursoVidaEntity cursoVida) {
    return repositoryDB.saveCursoVidaRepositoryDB(cursoVida);
  }

  Future<Either<Failure, List<CursoVidaEntity>>> getCursosVidaUsecase() {
    return repositoryDB.getCursosVidaRepositoryDB();
  }
}
