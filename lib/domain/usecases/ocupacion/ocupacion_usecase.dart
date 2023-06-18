import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/ocupacion_entity.dart';
import '../../repositories/ocupacion/ocupacion_repository.dart';

class OcupacionUsecase {
  final OcupacionRepository repository;

  OcupacionUsecase(this.repository);

  Future<Either<Failure, List<OcupacionEntity>>> getOcupacionesUsecase() {
    return repository.getOcupacionesRepository();
  }
}
