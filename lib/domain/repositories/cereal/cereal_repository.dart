import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/cereal_entity.dart';

abstract class CerealRepository {
  Future<Either<Failure, List<CerealEntity>>> getCerealesRepository(int dtoId);
}
