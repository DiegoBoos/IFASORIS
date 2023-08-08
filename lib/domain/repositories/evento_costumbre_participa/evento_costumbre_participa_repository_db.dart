import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../data/models/evento_costumbre_participa_model.dart';
import '../../entities/evento_costumbre_participa_entity.dart';

abstract class EventoCostumbreParticipaRepositoryDB {
  Future<Either<Failure, int>> saveEventoCostumbreParticipaRepositoryDB(
      EventoCostumbreParticipaEntity eventoCostumbreParticipa);

  Future<Either<Failure, List<EventoCostumbreParticipaEntity>>>
      getEventosCostumbresParticipaRepositoryDB();

  Future<Either<Failure, List<LstEventoCostumbreParticipa>>>
      getAsp6EventosCostumbresParticipaRepositoryDB(
          int? dimensionSocioCulturalPueblosIndigenasId);

  Future<Either<Failure, int>> saveAsp6EventosCostumbresParticipaRepositoryDB(
      int? dimensionSocioCulturalPueblosIndigenasId,
      List<LstEventoCostumbreParticipa> lstEventoCostumbreParticipa);
}
