import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/fruto_entity.dart';
import '../../../domain/repositories/fruto/fruto_repository.dart';
import '../../datasources/remote/fruto_remote_ds.dart';

class FrutoRepositoryImpl implements FrutoRepository {
  final FrutoRemoteDataSource frutoRemoteDataSource;

  FrutoRepositoryImpl({required this.frutoRemoteDataSource});

  @override
  Future<Either<Failure, List<FrutoEntity>>> getFrutosRepository(
      int dtoId) async {
    try {
      final result = await frutoRemoteDataSource.getFrutos(dtoId);

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
