import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/especie_animal_entity.dart';
import '../../../domain/repositories/especie_animal/especie_animal_repository.dart';
import '../../datasources/remote/especie_animal_remote_ds.dart';

class EspecieAnimalRepositoryImpl implements EspecieAnimalRepository {
  final EspecieAnimalRemoteDataSource especieAnimalRemoteDataSource;

  EspecieAnimalRepositoryImpl({required this.especieAnimalRemoteDataSource});

  @override
  Future<Either<Failure, List<EspecieAnimalEntity>>>
      getEspeciesAnimalesRepository(int dtoId) async {
    try {
      final result =
          await especieAnimalRemoteDataSource.getEspeciesAnimales(dtoId);

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
