import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/conducta_seguir/conducta_seguir_repository.dart';
import '../../datasources/remote/conducta_seguir_remote_ds.dart';
import '../../models/conducta_seguir.dart';

class ConductaSeguirRepositoryImpl implements ConductaSeguirRepository {
  final ConductaSeguirRemoteDataSource conductaSeguirRemoteDataSource;

  ConductaSeguirRepositoryImpl({required this.conductaSeguirRemoteDataSource});

  @override
  Future<Either<Failure, List<ConductaSeguirModel>>>
      getConductasSeguirRepository() async {
    try {
      final result = await conductaSeguirRemoteDataSource.getConductasSeguir();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
