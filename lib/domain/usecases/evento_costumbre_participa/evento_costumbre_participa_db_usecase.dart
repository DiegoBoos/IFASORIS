import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../data/models/evento_costumbre_participa_model.dart';
import '../../entities/evento_costumbre_participa_entity.dart';
import '../../repositories/evento_costumbre_participa/evento_costumbre_participa_repository_db.dart';

class EventoCostumbreParticipaUsecaseDB {
  final EventoCostumbreParticipaRepositoryDB repositoryDB;

  EventoCostumbreParticipaUsecaseDB(this.repositoryDB);

  Future<Either<Failure, int>> saveEventoCostumbreParticipaUsecaseDB(
      EventoCostumbreParticipaEntity eventoCostumbreParticipa) {
    return repositoryDB
        .saveEventoCostumbreParticipaRepositoryDB(eventoCostumbreParticipa);
  }

  Future<Either<Failure, List<EventoCostumbreParticipaEntity>>>
      getEventosCostumbresParticipaUsecaseDB() {
    return repositoryDB.getEventosCostumbresParticipaRepositoryDB();
  }

  Future<Either<Failure, List<LstEventoCostumbreParticipa>>>
      getAsp6EventosCostumbresParticipaUsecaseDB(
          int? dimensionSocioCulturalPueblosIndigenasId) {
    return repositoryDB.getAsp6EventosCostumbresParticipaRepositoryDB(
        dimensionSocioCulturalPueblosIndigenasId);
  }

  Future<Either<Failure, int>> saveAsp6EventosCostumbresParticipaUsecaseDB(
      int? dimensionSocioCulturalPueblosIndigenasId,
      List<LstEventoCostumbreParticipa> lstEventoCostumbreParticipa) {
    return repositoryDB.saveAsp6EventosCostumbresParticipaRepositoryDB(
        dimensionSocioCulturalPueblosIndigenasId, lstEventoCostumbreParticipa);
  }
}
