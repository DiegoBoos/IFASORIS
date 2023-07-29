import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/lugar_vacunacion_entity.dart';

abstract class LugarVacunacionRepository {
  Future<Either<Failure, List<LugarVacunacionEntity>>>
      getLugaresVacunacionRepository();
}
