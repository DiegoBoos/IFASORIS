import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/curso_vida.dart';

abstract class CursoVidaRepositoryDB {
  Future<Either<Failure, int>> saveCursoVidaRepositoryDB(
      CursoVidaEntity cursoVida);

  Future<Either<Failure, List<CursoVidaEntity>>> getCursosVidaRepositoryDB();
}
