import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tuberculo_platano_entity.dart';
import '../../../domain/repositories/tuberculo_platano_by_dpto/tuberculo_platano_by_dpto_repository.dart';
import '../../datasources/remote/tuberculo_platano_by_dpto_remote_ds.dart';

class TuberculoPlatanoByDptoRepositoryImpl
    implements TuberculoPlatanoByDptoRepository {
  final TuberculoPlatanoByDptoRemoteDataSource
      tuberculoPlatanoByDptoRemoteDataSource;

  TuberculoPlatanoByDptoRepositoryImpl(
      {required this.tuberculoPlatanoByDptoRemoteDataSource});

  @override
  Future<Either<Failure, List<TuberculoPlatanoEntity>>>
      getTuberculosPlatanosByDptoRepository(int dtoId) async {
    try {
      final result = await tuberculoPlatanoByDptoRemoteDataSource
          .getTuberculosPlatanosByDpto(dtoId);

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
