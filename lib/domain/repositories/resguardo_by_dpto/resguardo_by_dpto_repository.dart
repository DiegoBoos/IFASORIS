import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/resguardo_entity.dart';

abstract class ResguardoByDptoRepository {
  Future<Either<Failure, List<ResguardoEntity>>> getResguardosByDptoRepository(
      int dtoId);
}
