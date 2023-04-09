import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../domain/entities/tiempo_tarda_med_tradicional_entity.dart';
import '../../../domain/repositories/tiempo_tarda_med_tradicional/tiempo_tarda_med_tradicional_repository.dart';
import '../../datasources/remote/tiempo_tarda_med_tradicional_remote_ds.dart';

class TiempoTardaMedTradicionalRepositoryImpl
    implements TiempoTardaMedTradicionalRepository {
  final TiempoTardaMedTradicionalRemoteDataSource
      tiempoTardaMedTradicionalRemoteDataSource;

  TiempoTardaMedTradicionalRepositoryImpl(
      {required this.tiempoTardaMedTradicionalRemoteDataSource});

  @override
  Future<Either<Failure, List<TiempoTardaMedTradicionalEntity>>>
      getTiemposTardaMedTradicionalRepository() async {
    try {
      final result = await tiempoTardaMedTradicionalRemoteDataSource
          .getTiemposTardaMedTradicional();

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
