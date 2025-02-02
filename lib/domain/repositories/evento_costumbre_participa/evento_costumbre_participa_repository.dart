import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../entities/evento_costumbre_participa.dart';

abstract class EventoCostumbreParticipaRepository {
  Future<Either<Failure, List<EventoCostumbreParticipaEntity>>>
      getEventosCostumbresParticipaRepository(int dtoId);
}
