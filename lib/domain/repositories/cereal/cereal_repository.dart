import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/cereal.dart';

abstract class CerealRepository {
  Future<Either<Failure, List<CerealEntity>>> getCerealesRepository(int dtoId);
}
