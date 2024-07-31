import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/estado_via.dart';
import '../../repositories/estado_via/estado_via_repository.dart';

class EstadoViaUsecase {
  final EstadoViaRepository repository;

  EstadoViaUsecase(this.repository);

  Future<Either<Failure, List<EstadoViaEntity>>> getEstadoViasUsecase() {
    return repository.getEstadoViasRepository();
  }
}
