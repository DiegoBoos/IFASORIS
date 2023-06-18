import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/ocupacion_entity.dart';

abstract class OcupacionRepository {
  Future<Either<Failure, List<OcupacionEntity>>> getOcupacionesRepository();
}
