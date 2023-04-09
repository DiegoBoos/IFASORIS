import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/via_acceso_entity.dart';

import '../../../core/error/failure.dart';

abstract class ViaAccesoRepository {
  Future<Either<Failure, List<ViaAccesoEntity>>> getViasAccesoRepository();
}
