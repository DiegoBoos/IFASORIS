import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/alimentacion_entity.dart';

abstract class AlimentacionRepository {
  Future<Either<Failure, List<AlimentacionEntity>>>
      getAlimentacionesRepository();
}
