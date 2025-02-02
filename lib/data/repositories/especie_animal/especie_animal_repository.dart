import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/especie_animal/especie_animal_repository.dart';
import '../../datasources/remote/especie_animal_remote_ds.dart';
import '../../models/especie_animal.dart';

class EspecieAnimalRepositoryImpl implements EspecieAnimalRepository {
  final EspecieAnimalRemoteDataSource especieAnimalRemoteDataSource;

  EspecieAnimalRepositoryImpl({required this.especieAnimalRemoteDataSource});

  @override
  Future<Either<Failure, List<EspecieAnimalModel>>>
      getEspeciesAnimalesRepository(int dtoId) async {
    try {
      final result =
          await especieAnimalRemoteDataSource.getEspeciesAnimales(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
