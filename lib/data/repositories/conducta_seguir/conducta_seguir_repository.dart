import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/conducta_seguir_entity.dart';
import '../../../domain/repositories/conducta_seguir/conducta_seguir_repository.dart';
import '../../datasources/remote/conducta_seguir_remote_ds.dart';

class ConductaSeguirRepositoryImpl implements ConductaSeguirRepository {
  final ConductaSeguirRemoteDataSource conductaSeguirRemoteDataSource;

  ConductaSeguirRepositoryImpl({required this.conductaSeguirRemoteDataSource});

  @override
  Future<Either<Failure, List<ConductaSeguirEntity>>>
      getConductasSeguirRepository() async {
    try {
      final result = await conductaSeguirRemoteDataSource.getConductasSeguir();

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
