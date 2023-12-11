import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/evento_costumbre_participa_entity.dart';
import '../../../domain/repositories/evento_costumbre_participa/evento_costumbre_participa_repository.dart';
import '../../datasources/remote/evento_costumbre_participa_remote_ds.dart';

class EventoCostumbreParticipaRepositoryImpl
    implements EventoCostumbreParticipaRepository {
  final EventoCostumbreParticipaRemoteDataSource
      eventoCostumbreParticipaRemoteDataSource;

  EventoCostumbreParticipaRepositoryImpl(
      {required this.eventoCostumbreParticipaRemoteDataSource});

  @override
  Future<Either<Failure, List<EventoCostumbreParticipaEntity>>>
      getEventosCostumbresParticipaRepository(int dtoId) async {
    try {
      final result = await eventoCostumbreParticipaRemoteDataSource
          .getEventosCostumbresParticipa(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
