import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/via_acceso.dart';

abstract class ViaAccesoRepository {
  Future<Either<Failure, List<ViaAccesoEntity>>> getViasAccesoRepository(
      int dtoId);
}
