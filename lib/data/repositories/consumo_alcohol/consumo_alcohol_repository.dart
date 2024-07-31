import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/consumo_alcohol/consumo_alcohol_repository.dart';
import '../../datasources/remote/consumo_alcohol_remote_ds.dart';
import '../../models/consumo_alcohol.dart';

class ConsumoAlcoholRepositoryImpl implements ConsumoAlcoholRepository {
  final ConsumoAlcoholRemoteDataSource consumoAlcoholRemoteDataSource;

  ConsumoAlcoholRepositoryImpl({required this.consumoAlcoholRemoteDataSource});

  @override
  Future<Either<Failure, List<ConsumoAlcoholModel>>>
      getConsumosAlcoholRepository() async {
    try {
      final result = await consumoAlcoholRemoteDataSource.getConsumosAlcohol();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
