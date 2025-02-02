import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/alimentacion.dart';
import '../../repositories/alimentacion/alimentacion_repository.dart';

class AlimentacionUsecase {
  final AlimentacionRepository repository;

  AlimentacionUsecase(this.repository);

  Future<Either<Failure, List<AlimentacionEntity>>> getAlimentacionesUsecase() {
    return repository.getAlimentacionesRepository();
  }
}
