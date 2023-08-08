import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ifasoris/domain/entities/resguardo_entity.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/repositories/resguardo/resguardo_repository.dart';
import '../../datasources/remote/resguardo_remote_ds.dart';

class ResguardoRepositoryImpl implements ResguardoRepository {
  final ResguardoRemoteDataSource resguardoRemoteDataSource;

  ResguardoRepositoryImpl({required this.resguardoRemoteDataSource});

  @override
  Future<Either<Failure, List<ResguardoEntity>>> getResguardosRepository(
      int dtoId) async {
    try {
      final result = await resguardoRemoteDataSource.getResguardos(dtoId);

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
