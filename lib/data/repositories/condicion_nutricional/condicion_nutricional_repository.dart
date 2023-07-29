import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/condicion_nutricional_entity.dart';
import '../../../domain/repositories/condicion_nutricional/condicion_nutricional_repository.dart';
import '../../datasources/remote/condicion_nutricional_remote_ds.dart';

class CondicionNutricionalRepositoryImpl
    implements CondicionNutricionalRepository {
  final CondicionNutricionalRemoteDataSource
      condicionNutricionalRemoteDataSource;

  CondicionNutricionalRepositoryImpl(
      {required this.condicionNutricionalRemoteDataSource});

  @override
  Future<Either<Failure, List<CondicionNutricionalEntity>>>
      getCondicionesNutricionalesRepository() async {
    try {
      final result = await condicionNutricionalRemoteDataSource
          .getCondicionesNutricionales();

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
