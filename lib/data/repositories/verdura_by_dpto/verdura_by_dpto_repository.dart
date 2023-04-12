import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/verdura_entity.dart';
import '../../../domain/repositories/verdura_by_dpto/verdura_by_dpto_repository.dart';
import '../../datasources/remote/verdura_by_dpto_remote_ds.dart';

class VerduraByDptoRepositoryImpl implements VerduraByDptoRepository {
  final VerduraByDptoRemoteDataSource verduraByDptoRemoteDataSource;

  VerduraByDptoRepositoryImpl({required this.verduraByDptoRemoteDataSource});

  @override
  Future<Either<Failure, List<VerduraEntity>>> getVerdurasByDptoRepository(
      int dtoId) async {
    try {
      final result =
          await verduraByDptoRemoteDataSource.getVerdurasByDpto(dtoId);

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
