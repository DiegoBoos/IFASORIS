import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/ocupacion.dart';

abstract class OcupacionRepository {
  Future<Either<Failure, List<OcupacionEntity>>> getOcupacionesRepository();
}
