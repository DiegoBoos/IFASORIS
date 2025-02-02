import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/fruto/fruto_repository.dart';
import '../../datasources/remote/fruto_remote_ds.dart';
import '../../models/fruto.dart';

class FrutoRepositoryImpl implements FrutoRepository {
  final FrutoRemoteDataSource frutoRemoteDataSource;

  FrutoRepositoryImpl({required this.frutoRemoteDataSource});

  @override
  Future<Either<Failure, List<FrutoModel>>> getFrutosRepository(
      int dtoId) async {
    try {
      final result = await frutoRemoteDataSource.getFrutos(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
