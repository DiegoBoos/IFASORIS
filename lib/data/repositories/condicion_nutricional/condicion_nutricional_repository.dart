import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/condicion_nutricional/condicion_nutricional_repository.dart';
import '../../datasources/remote/condicion_nutricional_remote_ds.dart';
import '../../models/condicion_nutricional.dart';

class CondicionNutricionalRepositoryImpl
    implements CondicionNutricionalRepository {
  final CondicionNutricionalRemoteDataSource
      condicionNutricionalRemoteDataSource;

  CondicionNutricionalRepositoryImpl(
      {required this.condicionNutricionalRemoteDataSource});

  @override
  Future<Either<Failure, List<CondicionNutricionalModel>>>
      getCondicionesNutricionalesRepository() async {
    try {
      final result = await condicionNutricionalRemoteDataSource
          .getCondicionesNutricionales();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
