import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/verdura.dart';

abstract class VerduraRepository {
  Future<Either<Failure, List<VerduraEntity>>> getVerdurasRepository(int dtoId);
}
