import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/especie_animal_entity.dart';
import '../../../domain/repositories/especie_animal_by_dpto/especie_animal_by_dpto_repository.dart';
import '../../datasources/remote/especie_animal_by_dpto_remote_ds.dart';

class EspecieAnimalByDptoRepositoryImpl
    implements EspecieAnimalByDptoRepository {
  final EspecieAnimalByDptoRemoteDataSource especieAnimalByDptoRemoteDataSource;

  EspecieAnimalByDptoRepositoryImpl(
      {required this.especieAnimalByDptoRemoteDataSource});

  @override
  Future<Either<Failure, List<EspecieAnimalEntity>>>
      getEspeciesAnimalesByDptoRepository(int dtoId) async {
    try {
      final result = await especieAnimalByDptoRemoteDataSource
          .getEspeciesAnimalesByDpto(dtoId);

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
