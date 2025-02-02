import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/leguminosa/leguminosa_repository.dart';
import '../../datasources/remote/leguminosa_remote_ds.dart';
import '../../models/leguminosa.dart';

class LeguminosaRepositoryImpl implements LeguminosaRepository {
  final LeguminosaRemoteDataSource leguminosaRemoteDataSource;

  LeguminosaRepositoryImpl({required this.leguminosaRemoteDataSource});

  @override
  Future<Either<Failure, List<LeguminosaModel>>> getLeguminosasRepository(
      int dtoId) async {
    try {
      final result = await leguminosaRemoteDataSource.getLeguminosas(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
