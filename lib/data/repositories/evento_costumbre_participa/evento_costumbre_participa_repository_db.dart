import 'package:dartz/dartz.dart';
import 'package:ifasoris/data/models/evento_costumbre_participa.dart';

import '../../../core/constants.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/evento_costumbre_participa.dart';
import '../../../domain/repositories/evento_costumbre_participa/evento_costumbre_participa_repository_db.dart';
import '../../datasources/local/evento_costumbre_participa_local_ds.dart';

class EventoCostumbreParticipaRepositoryDBImpl
    implements EventoCostumbreParticipaRepositoryDB {
  final EventoCostumbreParticipaLocalDataSource
      eventoCostumbreParticipaLocalDataSource;

  EventoCostumbreParticipaRepositoryDBImpl(
      {required this.eventoCostumbreParticipaLocalDataSource});

  @override
  Future<Either<Failure, List<EventoCostumbreParticipaModel>>>
      getEventosCostumbresParticipaRepositoryDB() async {
    try {
      final result = await eventoCostumbreParticipaLocalDataSource
          .getEventosCostumbresParticipa();
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveEventoCostumbreParticipaRepositoryDB(
      EventoCostumbreParticipaEntity eventoCostumbreParticipa) async {
    try {
      final eventoCostumbreParticipaModel =
          EventoCostumbreParticipaModel.fromEntity(eventoCostumbreParticipa);
      final result = await eventoCostumbreParticipaLocalDataSource
          .saveEventoCostumbreParticipa(eventoCostumbreParticipaModel);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, List<LstEventoCostumbreParticipa>>>
      getAsp6EventosCostumbresParticipaRepositoryDB(
          int? dimensionSocioCulturalPueblosIndigenasId) async {
    try {
      final result = await eventoCostumbreParticipaLocalDataSource
          .getAsp6EventosCostumbresParticipa(
              dimensionSocioCulturalPueblosIndigenasId);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }

  @override
  Future<Either<Failure, int>> saveAsp6EventosCostumbresParticipaRepositoryDB(
      int? dimensionSocioCulturalPueblosIndigenasId,
      List<LstEventoCostumbreParticipa> lstEventoCostumbreParticipa) async {
    try {
      final result = await eventoCostumbreParticipaLocalDataSource
          .saveAsp6EventosCostumbresParticipa(
              dimensionSocioCulturalPueblosIndigenasId,
              lstEventoCostumbreParticipa);
      return Right(result);
    } on DatabaseFailure catch (e) {
      return Left(DatabaseFailure(e.properties));
    } on ServerFailure {
      return const Left(DatabaseFailure([unexpectedErrorMessage]));
    }
  }
}
