import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/cereal_entity.dart';

abstract class CerealByDptoRepository {
  Future<Either<Failure, List<CerealEntity>>> getCerealesByDptoRepository(
      int dtoId);
}
