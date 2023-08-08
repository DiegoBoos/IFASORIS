import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tuberculo_platano_entity.dart';
import '../../../domain/repositories/tuberculo_platano/tuberculo_platano_repository.dart';
import '../../datasources/remote/tuberculo_platano_remote_ds.dart';

class TuberculoPlatanoRepositoryImpl implements TuberculoPlatanoRepository {
  final TuberculoPlatanoRemoteDataSource tuberculoPlatanoRemoteDataSource;

  TuberculoPlatanoRepositoryImpl(
      {required this.tuberculoPlatanoRemoteDataSource});

  @override
  Future<Either<Failure, List<TuberculoPlatanoEntity>>>
      getTuberculosPlatanosRepository(int dtoId) async {
    try {
      final result =
          await tuberculoPlatanoRemoteDataSource.getTuberculosPlatanos(dtoId);

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
