import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/etnia/etnia_repository.dart';
import '../../datasources/remote/etnia_remote_ds.dart';
import '../../models/etnia.dart';

class EtniaRepositoryImpl implements EtniaRepository {
  final EtniaRemoteDataSource etniaRemoteDataSource;

  EtniaRepositoryImpl({required this.etniaRemoteDataSource});

  @override
  Future<Either<Failure, List<EtniaModel>>> getEtniasRepository() async {
    try {
      final result = await etniaRemoteDataSource.getEtnias();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
