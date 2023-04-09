import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/resguardo_by_dpto_entity.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/repositories/resguardo_by_dpto/resguardo_by_dpto_repository.dart';
import '../../datasources/remote/resguardo_by_dpto_remote_ds.dart';

class ResguardoByDptoRepositoryImpl implements ResguardoByDptoRepository {
  final ResguardoByDptoRemoteDataSource resguardoByDptoRemoteDataSource;

  ResguardoByDptoRepositoryImpl(
      {required this.resguardoByDptoRemoteDataSource});

  @override
  Future<Either<Failure, List<ResguardoByDptoEntity>>>
      getResguardosByDptoRepository(int dtoId) async {
    try {
      final resguardoByDptoResponse =
          await resguardoByDptoRemoteDataSource.getResguardosByDpto(dtoId);

      return Right(resguardoByDptoResponse);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on ServerException {
      return const Left(ServerFailure(['Excepción no controlada']));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
