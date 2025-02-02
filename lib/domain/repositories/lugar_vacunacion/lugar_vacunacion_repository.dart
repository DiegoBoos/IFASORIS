import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/lugar_vacunacion.dart';

abstract class LugarVacunacionRepository {
  Future<Either<Failure, List<LugarVacunacionEntity>>>
      getLugaresVacunacionRepository();
}
