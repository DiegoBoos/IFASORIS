import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/evento_costumbre_participa_entity.dart';

abstract class EventoCostumbreParticipaRepository {
  Future<Either<Failure, List<EventoCostumbreParticipaEntity>>>
      getEventosCostumbresParticipaRepository();
}
