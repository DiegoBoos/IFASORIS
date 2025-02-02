import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/hortaliza.dart';

abstract class HortalizaRepository {
  Future<Either<Failure, List<HortalizaEntity>>> getHortalizasRepository(
      int dtoId);
}
