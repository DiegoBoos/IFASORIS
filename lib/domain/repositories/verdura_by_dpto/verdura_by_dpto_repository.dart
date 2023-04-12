import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/verdura_entity.dart';

abstract class VerduraByDptoRepository {
  Future<Either<Failure, List<VerduraEntity>>> getVerdurasByDptoRepository(
      int dtoId);
}
