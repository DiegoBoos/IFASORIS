import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/hortaliza_entity.dart';

abstract class HortalizaByDptoRepository {
  Future<Either<Failure, List<HortalizaEntity>>> getHortalizasByDptoRepository(
      int dtoId);
}
