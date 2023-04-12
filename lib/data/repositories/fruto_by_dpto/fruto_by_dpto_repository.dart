import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/fruto_entity.dart';
import '../../../domain/repositories/fruto_by_dpto/fruto_by_dpto_repository.dart';
import '../../datasources/remote/fruto_by_dpto_remote_ds.dart';

class FrutoByDptoRepositoryImpl implements FrutoByDptoRepository {
  final FrutoByDptoRemoteDataSource frutoByDptoRemoteDataSource;

  FrutoByDptoRepositoryImpl({required this.frutoByDptoRemoteDataSource});

  @override
  Future<Either<Failure, List<FrutoEntity>>> getFrutosByDptoRepository(
      int dtoId) async {
    try {
      final result = await frutoByDptoRemoteDataSource.getFrutosByDpto(dtoId);

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
