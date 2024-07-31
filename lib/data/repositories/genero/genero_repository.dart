import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/genero/genero_repository.dart';
import '../../datasources/remote/genero_remote_ds.dart';
import '../../models/genero.dart';

class GeneroRepositoryImpl implements GeneroRepository {
  final GeneroRemoteDataSource generoRemoteDataSource;

  GeneroRepositoryImpl({required this.generoRemoteDataSource});

  @override
  Future<Either<Failure, List<GeneroModel>>> getGenerosRepository() async {
    try {
      final result = await generoRemoteDataSource.getGeneros();

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
