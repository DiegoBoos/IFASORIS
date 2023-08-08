import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/verdura_entity.dart';

abstract class VerduraRepository {
  Future<Either<Failure, List<VerduraEntity>>> getVerdurasRepository(int dtoId);
}
