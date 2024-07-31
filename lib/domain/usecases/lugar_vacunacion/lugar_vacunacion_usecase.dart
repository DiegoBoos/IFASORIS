import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/lugar_vacunacion.dart';
import '../../repositories/lugar_vacunacion/lugar_vacunacion_repository.dart';

class LugarVacunacionUsecase {
  final LugarVacunacionRepository repository;

  LugarVacunacionUsecase(this.repository);

  Future<Either<Failure, List<LugarVacunacionEntity>>>
      getLugaresVacunacionUsecase() {
    return repository.getLugaresVacunacionRepository();
  }
}
