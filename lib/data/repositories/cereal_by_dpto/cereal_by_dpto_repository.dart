import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/cereal_entity.dart';
import '../../../domain/repositories/cereal_by_dpto/cereal_by_dpto_repository.dart';
import '../../datasources/remote/cereal_by_dpto_remote_ds.dart';

class CerealByDptoRepositoryImpl implements CerealByDptoRepository {
  final CerealByDptoRemoteDataSource cerealByDptoRemoteDataSource;

  CerealByDptoRepositoryImpl({required this.cerealByDptoRemoteDataSource});

  @override
  Future<Either<Failure, List<CerealEntity>>> getCerealesByDptoRepository(
      int dtoId) async {
    try {
      final result =
          await cerealByDptoRemoteDataSource.getCerealesByDpto(dtoId);

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
