import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/presencia_animal_vivienda_entity.dart';
import '../../../domain/repositories/presencia_animal_vivienda_by_dpto/presencia_animal_vivienda_by_dpto_repository.dart';
import '../../datasources/remote/presencia_animal_vivienda_by_dpto_remote_ds.dart';

class PresenciaAnimalViviendaByDptoRepositoryImpl
    implements PresenciaAnimalViviendaByDptoRepository {
  final PresenciaAnimalViviendaByDptoRemoteDataSource
      presenciaAnimalViviendaByDptoRemoteDataSource;

  PresenciaAnimalViviendaByDptoRepositoryImpl(
      {required this.presenciaAnimalViviendaByDptoRemoteDataSource});

  @override
  Future<Either<Failure, List<PresenciaAnimalViviendaEntity>>>
      getPresenciaAnimalesViviendaByDptoRepository(int dtoId) async {
    try {
      final result = await presenciaAnimalViviendaByDptoRemoteDataSource
          .getPresenciaAnimalesViviendaByDpto(dtoId);

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
