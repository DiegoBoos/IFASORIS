import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/presencia_animal_vivienda/presencia_animal_vivienda_repository.dart';
import '../../datasources/remote/presencia_animal_vivienda_remote_ds.dart';
import '../../models/presencia_animal_vivienda.dart';

class PresenciaAnimalViviendaRepositoryImpl
    implements PresenciaAnimalViviendaRepository {
  final PresenciaAnimalViviendaRemoteDataSource
      presenciaAnimalViviendaRemoteDataSource;

  PresenciaAnimalViviendaRepositoryImpl(
      {required this.presenciaAnimalViviendaRemoteDataSource});

  @override
  Future<Either<Failure, List<PresenciaAnimalViviendaModel>>>
      getPresenciaAnimalesViviendaRepository(int dtoId) async {
    try {
      final result = await presenciaAnimalViviendaRemoteDataSource
          .getPresenciaAnimalesVivienda(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
