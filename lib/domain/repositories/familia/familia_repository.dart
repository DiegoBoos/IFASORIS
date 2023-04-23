import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/familia_entity.dart';

abstract class FamiliaRepository {
  Future<Either<Failure, FamiliaEntity>> createFamiliaRepository(
      FamiliaEntity familia);
}
