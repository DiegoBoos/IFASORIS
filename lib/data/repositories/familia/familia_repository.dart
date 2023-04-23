import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/familia_entity.dart';
import '../../../domain/repositories/familia/familia_repository.dart';
import '../../datasources/remote/familia_remote_ds.dart';

class FamiliaRepositoryImpl implements FamiliaRepository {
  final FamiliaRemoteDataSource familiaRemoteDataSource;

  FamiliaRepositoryImpl({required this.familiaRemoteDataSource});

  @override
  Future<Either<Failure, FamiliaEntity>> createFamiliaRepository(
      FamiliaEntity familia) async {
    try {
      final result = await familiaRemoteDataSource.createFamilia(familia);

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
