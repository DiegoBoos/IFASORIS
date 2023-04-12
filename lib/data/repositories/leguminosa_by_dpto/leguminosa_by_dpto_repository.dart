import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/leguminosa_entity.dart';
import '../../../domain/repositories/leguminosa_by_dpto/leguminosa_by_dpto_repository.dart';
import '../../datasources/remote/leguminosa_by_dpto_remote_ds.dart';

class LeguminosaByDptoRepositoryImpl implements LeguminosaByDptoRepository {
  final LeguminosaByDptoRemoteDataSource leguminosaByDptoRemoteDataSource;

  LeguminosaByDptoRepositoryImpl(
      {required this.leguminosaByDptoRemoteDataSource});

  @override
  Future<Either<Failure, List<LeguminosaEntity>>>
      getLeguminosasByDptoRepository(int dtoId) async {
    try {
      final result =
          await leguminosaByDptoRemoteDataSource.getLeguminosasByDpto(dtoId);

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
