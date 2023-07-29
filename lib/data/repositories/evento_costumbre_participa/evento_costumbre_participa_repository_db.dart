import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/evento_costumbre_participa_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/evento_costumbre_participa_entity.dart';
import '../../../domain/repositories/evento_costumbre_participa/evento_costumbre_participa_repository_db.dart';
import '../../datasources/local/evento_costumbre_participa_local_ds.dart';

class EventoCostumbreParticipaRepositoryDBImpl
    implements EventoCostumbreParticipaRepositoryDB {
  final EventoCostumbreParticipaLocalDataSource
      eventoCostumbreParticipaLocalDataSource;

  EventoCostumbreParticipaRepositoryDBImpl(
      {required this.eventoCostumbreParticipaLocalDataSource});

  @override
  Future<Either<Failure, List<EventoCostumbreParticipaEntity>>>
      getEventosCostumbresParticipaRepositoryDB() async {
    try {
      final result = await eventoCostumbreParticipaLocalDataSource
          .getEventosCostumbresParticipa();
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveEventoCostumbreParticipaRepositoryDB(
      EventoCostumbreParticipaEntity eventoCostumbreParticipa) async {
    try {
      final result = await eventoCostumbreParticipaLocalDataSource
          .saveEventoCostumbreParticipa(eventoCostumbreParticipa);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, List<LstEventoCostumbreParticipa>>>
      getAsp6EventosCostumbresParticipaRepositoryDB(
          int? dimensionSocioculturalPueblosIndigenasId) async {
    try {
      final result = await eventoCostumbreParticipaLocalDataSource
          .getAsp6EventosCostumbresParticipa(
              dimensionSocioculturalPueblosIndigenasId);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }

  @override
  Future<Either<Failure, int>> saveAsp6EventosCostumbresParticipaRepositoryDB(
      int? dimensionSocioculturalPueblosIndigenasId,
      List<LstEventoCostumbreParticipa> lstEventoCostumbreParticipa) async {
    try {
      final result = await eventoCostumbreParticipaLocalDataSource
          .saveAsp6EventosCostumbresParticipa(
              dimensionSocioculturalPueblosIndigenasId,
              lstEventoCostumbreParticipa);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    }
  }
}
