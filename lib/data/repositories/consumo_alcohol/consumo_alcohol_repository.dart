import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/consumo_alcohol_entity.dart';
import '../../../domain/repositories/consumo_alcohol/consumo_alcohol_repository.dart';
import '../../datasources/remote/consumo_alcohol_remote_ds.dart';

class ConsumoAlcoholRepositoryImpl implements ConsumoAlcoholRepository {
  final ConsumoAlcoholRemoteDataSource consumoAlcoholRemoteDataSource;

  ConsumoAlcoholRepositoryImpl({required this.consumoAlcoholRemoteDataSource});

  @override
  Future<Either<Failure, List<ConsumoAlcoholEntity>>>
      getConsumosAlcoholRepository() async {
    try {
      final result = await consumoAlcoholRemoteDataSource.getConsumosAlcohol();

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
