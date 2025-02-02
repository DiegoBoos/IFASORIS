import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/familia.dart';

abstract class FamiliaRepository {
  Future<Either<Failure, FamiliaEntity>> createFamiliaRepository(
      FamiliaEntity familia);
}
