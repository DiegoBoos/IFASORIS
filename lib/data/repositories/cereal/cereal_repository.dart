import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/cereal_entity.dart';
import '../../../domain/repositories/cereal/cereal_repository.dart';
import '../../datasources/remote/cereal_remote_ds.dart';

class CerealRepositoryImpl implements CerealRepository {
  final CerealRemoteDataSource cerealRemoteDataSource;

  CerealRepositoryImpl({required this.cerealRemoteDataSource});

  @override
  Future<Either<Failure, List<CerealEntity>>> getCerealesRepository(
      int dtoId) async {
    try {
      final result = await cerealRemoteDataSource.getCereales(dtoId);

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
