import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/leguminosa.dart';

abstract class LeguminosaRepository {
  Future<Either<Failure, List<LeguminosaEntity>>> getLeguminosasRepository(
      int dtoId);
}
