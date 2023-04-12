import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/hortaliza_entity.dart';
import '../../../domain/repositories/hortaliza_by_dpto/hortaliza_by_dpto_repository.dart';
import '../../datasources/remote/hortaliza_by_dpto_remote_ds.dart';

class HortalizaByDptoRepositoryImpl implements HortalizaByDptoRepository {
  final HortalizaByDptoRemoteDataSource hortalizaByDptoRemoteDataSource;

  HortalizaByDptoRepositoryImpl(
      {required this.hortalizaByDptoRemoteDataSource});

  @override
  Future<Either<Failure, List<HortalizaEntity>>> getHortalizasByDptoRepository(
      int dtoId) async {
    try {
      final result =
          await hortalizaByDptoRemoteDataSource.getHortalizasByDpto(dtoId);

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
