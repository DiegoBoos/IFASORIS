import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/repositories/ficha/ficha_repository.dart';
import '../../datasources/remote/ficha_remote_ds.dart';

class FichaRepositoryImpl implements FichaRepository {
  final FichaRemoteDataSource fichaRemoteDataSource;

  FichaRepositoryImpl({required this.fichaRemoteDataSource});

  @override
  Future<Either<Failure, List<dynamic>>> createFichaRepository() async {
    try {
      final result = await fichaRemoteDataSource.createFicha();

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
