import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/evento_costumbre_participa_entity.dart';
import '../../repositories/evento_costumbre_participa/evento_costumbre_participa_repository.dart';

class EventoCostumbreParticipaUsecase {
  final EventoCostumbreParticipaRepository repository;

  EventoCostumbreParticipaUsecase(this.repository);

  Future<Either<Failure, List<EventoCostumbreParticipaEntity>>>
      getEventosCostumbresParticipaUsecase(int dtoId) {
    return repository.getEventosCostumbresParticipaRepository(dtoId);
  }
}
