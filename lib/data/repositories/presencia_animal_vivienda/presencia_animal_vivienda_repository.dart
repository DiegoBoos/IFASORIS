import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/presencia_animal_vivienda_entity.dart';
import '../../../domain/repositories/presencia_animal_vivienda/presencia_animal_vivienda_repository.dart';
import '../../datasources/remote/presencia_animal_vivienda_remote_ds.dart';

class PresenciaAnimalViviendaRepositoryImpl
    implements PresenciaAnimalViviendaRepository {
  final PresenciaAnimalViviendaRemoteDataSource
      presenciaAnimalViviendaRemoteDataSource;

  PresenciaAnimalViviendaRepositoryImpl(
      {required this.presenciaAnimalViviendaRemoteDataSource});

  @override
  Future<Either<Failure, List<PresenciaAnimalViviendaEntity>>>
      getPresenciaAnimalesViviendaRepository(int dtoId) async {
    try {
      final result = await presenciaAnimalViviendaRemoteDataSource
          .getPresenciaAnimalesVivienda(dtoId);

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
