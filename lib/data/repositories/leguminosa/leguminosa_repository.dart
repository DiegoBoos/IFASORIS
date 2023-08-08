import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/leguminosa_entity.dart';
import '../../../domain/repositories/leguminosa/leguminosa_repository.dart';
import '../../datasources/remote/leguminosa_remote_ds.dart';

class LeguminosaRepositoryImpl implements LeguminosaRepository {
  final LeguminosaRemoteDataSource leguminosaRemoteDataSource;

  LeguminosaRepositoryImpl({required this.leguminosaRemoteDataSource});

  @override
  Future<Either<Failure, List<LeguminosaEntity>>> getLeguminosasRepository(
      int dtoId) async {
    try {
      final result = await leguminosaRemoteDataSource.getLeguminosas(dtoId);

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
