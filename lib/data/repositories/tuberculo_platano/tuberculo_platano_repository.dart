import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../domain/repositories/tuberculo_platano/tuberculo_platano_repository.dart';
import '../../datasources/remote/tuberculo_platano_remote_ds.dart';
import '../../models/tuberculo_platano.dart';

class TuberculoPlatanoRepositoryImpl implements TuberculoPlatanoRepository {
  final TuberculoPlatanoRemoteDataSource tuberculoPlatanoRemoteDataSource;

  TuberculoPlatanoRepositoryImpl(
      {required this.tuberculoPlatanoRemoteDataSource});

  @override
  Future<Either<Failure, List<TuberculoPlatanoModel>>>
      getTuberculosPlatanosRepository(int dtoId) async {
    try {
      final result =
          await tuberculoPlatanoRemoteDataSource.getTuberculosPlatanos(dtoId);

      return Right(result);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.properties));
    } on SocketException catch (e) {
      return Left(ConnectionFailure([e.message]));
    }
  }
}
