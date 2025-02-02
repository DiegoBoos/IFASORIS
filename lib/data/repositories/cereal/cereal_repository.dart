import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/cereal/cereal_repository.dart';
import '../../datasources/remote/cereal_remote_ds.dart';
import '../../models/cereal.dart';

class CerealRepositoryImpl implements CerealRepository {
  final CerealRemoteDataSource cerealRemoteDataSource;

  CerealRepositoryImpl({required this.cerealRemoteDataSource});

  @override
  Future<Either<Failure, List<CerealModel>>> getCerealesRepository(
      int dtoId) async {
    try {
      final result = await cerealRemoteDataSource.getCereales(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
