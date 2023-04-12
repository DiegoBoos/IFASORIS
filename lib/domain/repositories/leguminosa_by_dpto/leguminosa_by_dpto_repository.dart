import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/leguminosa_entity.dart';

abstract class LeguminosaByDptoRepository {
  Future<Either<Failure, List<LeguminosaEntity>>>
      getLeguminosasByDptoRepository(int dtoId);
}
