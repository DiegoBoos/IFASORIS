import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/curso_vida.dart';

abstract class CursoVidaRepository {
  Future<Either<Failure, List<CursoVidaEntity>>> getCursosVidaRepository();
}
