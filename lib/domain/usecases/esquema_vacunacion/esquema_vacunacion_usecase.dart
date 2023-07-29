import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/esquema_vacunacion_entity.dart';
import '../../repositories/esquema_vacunacion/esquema_vacunacion_repository.dart';

class EsquemaVacunacionUsecase {
  final EsquemaVacunacionRepository repository;

  EsquemaVacunacionUsecase(this.repository);

  Future<Either<Failure, List<EsquemaVacunacionEntity>>>
      getEsquemasVacunacionUsecase() {
    return repository.getEsquemasVacunacionRepository();
  }
}
