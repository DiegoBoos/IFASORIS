import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/autoridad_indigena_entity.dart';
import '../../../domain/repositories/autoridad_indigena/autoridad_indigena_repository.dart';
import '../../datasources/remote/autoridad_indigena_remote_ds.dart';

class AutoridadIndigenaRepositoryImpl implements AutoridadIndigenaRepository {
  final AutoridadIndigenaRemoteDataSource autoridadIndigenaRemoteDataSource;

  AutoridadIndigenaRepositoryImpl(
      {required this.autoridadIndigenaRemoteDataSource});

  @override
  Future<Either<Failure, List<AutoridadIndigenaEntity>>>
      getAutoridadesIndigenasRepository(int dtoId) async {
    try {
      final result = await autoridadIndigenaRemoteDataSource
          .getAutoridadesIndigenas(dtoId);

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
